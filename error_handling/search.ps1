
$SecurePassword = ConvertTo-SecureString -String "sp_key"  -AsPlainText -Force
$TenantId = "4e5dff48-af2c-4e7e-a5fa-bb6560ec04b6"
$AppId = "cc251fb5-6194-4c74-87ef-e96fa1a2b85f"
$testing = '743b758a-f6e7-4823-b706-950a64a6c9f9'

$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $AppId, $SecurePassword

try {
  Update-AzConfig -DefaultSubscriptionForLogin $testing -ErrorAction Stop
}
catch {
  $contextError = $_
  Write-Error "Error setting default context for sub $testing"
  throw
}

try {
  $connection = Connect-AzAccount -ServicePrincipal -TenantId $TenantId -Credential $Credential -ErrorAction Stop
}
catch {
  $connectError =$_
  Write-Error "Error connecting"
  Write-Error $connectError | Format-List * -Force
  throw
}

Set-AzContext -Subscription $testing

$entries = [System.Collections.ArrayList]@(
  @(New-Object -Type PSObject -Property @{
    "Name"  = "powershell"
    "State" = "ON"
    "RG"    = "terraform"
  })
)

$onvms = @(
  @{
    "Name" = "powershell"
  }
)


$offvms = @()

$formatDesiredStateBlock = {
  param($vmName)

  if ( $onvms | Where-Object { $_.Name -eq $vmName }) {
    'ON'
  } elseif ( $offvms | Where-Object { $_.Name -eq $vmName }) {
    'OFF'
  } else {
    'UNKNOWN'
  }
}
$formatCurrentStateBlock = {
  param($vmName,  $rg)

  $status = Get-AzVM -ResourceGroupName $rg -Name $vmName -Status

  if (       $status.Statuses.DisplayStatus[1] -like "*running*") {
    'ON'
  } elseif ( $status.Statuses.DisplayStatus[1] -like "*deallocated*") {
    'OFF'
  } else {
    'UNKNOWN'
  }
}

$entries | Format-Table -AutoSize @{label = 'Machine'; e = 'Name' ; width = 10},
RG,
@{label = 'Commanded State' ; e = 'State'; width = 14},
@{label = 'Current State'   ; e = { &$formatCurrentStateBlock $_.Name $_.RG }; width = 14}
