function Set-KeyVault {
  param (
    $kvName
  )

  $value = [PSCustomObject]@{
    "kvName"        = $kvName
  }


  Write-Host "Processing AKV " + $value

  return $value
}

function Set-k8sCluster {
  param (
    $subscription,
    $resourceGroup,
    $clusterName
  )

  $value = [PSCustomObject]@{
    "subscription"  = $subscription;
    "resourceGroup" = $resourceGroup;
    "clusterName"   = $clusterName
  }

  Write-Host "Processing K8S " + $value

  return $value
}

$myJson = Get-Content .\test.json -Raw | ConvertFrom-Json

ForEach ($config in $myJson) {
  if ($config.target -eq "akv") {
    Set-KeyVault   -kvName $config.target_name
  } elseif ($config.target -eq "k8s") {
    Set-k8sCluster -subscription $config.target_sub -resourceGroup $config.target_rg -clusterName $config.target_name
  }
}
