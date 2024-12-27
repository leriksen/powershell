Get-Process
1/0; Write-Host "non-terminating"

$collection = @(
  '~/data.yml',
  '~/nope',
  '~/salesorder.csv'
)

foreach ($file in $collection) {
  Get-Item -Path $file -ErrorAction Stop
}

$item = Get-Item -Path '~/salesorder.csv' -ErrorAction Stop
Write-Host $item

$item = ''

try {
  $item = Get-Item -Path '~/nope.csv' -ErrorAction Stop
}
catch {
  Write-Host "in the catch"
  throw
}

Write-Host "$item is not scoped to try"

try {
  $webResult = Invoke-WebRequest -Uri 'https://google.com/nope.html' -ErrorAction Stop
}
catch {
  $theError = $_
  if ($theError.Exception -like "*404*") {
    Write-Error 'Not found'
  }
}

$SecurePassword = ConvertTo-SecureString -String "mz98Q~JBLRCaMmv_aYS8CJz3pCu1EPQBE~c5qc25"  -AsPlainText -Force
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

$nonprod = "2884ad0b-0ac1-4f07-a315-cba72baeec5a"

try {
  $context = Set-AzContext -Subscription $nonprod -ErrorAction Stop
}
catch {
  $contextError = $_
  Write-Error "Error setting context"
  Write-Error $contextError | Format-List * -Force
}

try {
  $runner = Start-AzVM -Id '/subscriptions/743b758a-f6e7-4823-b706-950a64a6c9f9/resourcegroups/terraform/providers/Microsoft.Compute/virtualMachines/powershell'
}
catch {
  $startError = $_
  Write-Error "Error starting VM"
  Write-Error $startError | Format-List * -Force
}

try {
  $status = Get-AzVM -ResourceGroupName terraform -Name powershell
}
catch {
  $statusError = $_
  Write-Error "Error getting status of VM"
  Write-Error $statusError | Foramt-List * -Force
}

