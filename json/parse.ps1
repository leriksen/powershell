function Set-KeyVault {
  param (
    $subscription,
    $resourceGroup,
    $kvName
  )

  $value = [PSCustomObject]@{
    "subscription"  = $subscription;
    "resourceGroup" = $resourceGroup;
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

Write-Host $(Get-Location)

$myJson = Get-Content .\test.json -Raw | ConvertFrom-Json

ForEach ($config in $myJson) {
  if ($config.target -eq "akv") {
    Set-KeyVault   -subscription $config.target_sub -resourceGroup $config.target_rg -kvName $config.target_name
  } elseif ($config.target -eq "k8s") {
    Set-k8sCluster -subscription $config.target_sub -resourceGroup $config.target_rg -clusterName $config.target_name
  }
}
