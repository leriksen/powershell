$private:iterations = 1..128

$private:list = @()

foreach ($private:item in $iterations) {
  $private:state = Get-Random -InputObject ([bool]$True,[bool]$False)

  if ( $state -eq $False) {
    $private:object = @{
      "Name"  = "Item $item";
      "State" = $state
    }



    

    $list += $object
  }
}

$private:iterationCount = 0
$private:limit = 5
do {
  $private:staticLimit= $list.Count
  $private:replacementList = @()

  # because the modify the list, we cant use it as a control for looping
  # so we statically limit the iteration count
  for ($private:index = 0; $index -lt $staticLimit; $index++) {
    $private:item = $list[$index]

    Write-Output "Got $($item | Format-Table | Out-String)"

    $private:state = Get-Random -InputObject ([bool]$True,[bool]$False)
  
    if ( $state -eq $False) {
      Write-Output "requeing"
      $replacementList += $item
    }
  }

  $list = $replacementList
  Write-Output "There are $($list.Count) items remaining"

} while ($list.Count -gt 0 -and $iterationCount++ -lt $limit)