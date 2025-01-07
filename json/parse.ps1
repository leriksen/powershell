function Get-JFrogToken
{
  param(
    $scope
  )

  Write-Host "generating jfrog token for scope $scope"

  # ascii letters and numbers
  $token = -join ((48..57) + (65..90) | Get-Random -Count 25 | %{ [char]$_ })

  return ConvertTo-SecureString -String $token -AsPlainText
}

function Set-KeyVault {
  param (
    $kvName,
    $kvSecretName,
    $kvSecretValue
  )

  $value = [PSCustomObject]@{
    "kvName"        = $kvName;
    "kvSecretName"  = $kvSecretName;
    "kvSecretValue" = $kvSecretValue
  }


  Write-Host "Processing AKV " + $value

  return Set-AzKeyVaultSecret -VaultName $kvName -Name $kvSecretName -SecretValue $kvSecretValue
}

function Set-k8sCluster {
  param (
    $subscription,
    $resourceGroup,
    $clusterName,
    $secret
  )

  $value = [PSCustomObject]@{
    "subscription"  = $subscription;
    "resourceGroup" = $resourceGroup;
    "clusterName"   = $clusterName;
    "secret"        = $secret
  }

  Write-Host "Processing K8S " + $value

  return $value
}

$myJson = Get-Content .\test.json -Raw | ConvertFrom-Json

ForEach ($config in $myJson) {
  $token = Get-JFrogToken($config.scope)

  if ($config.target -eq "akv") {
    Set-KeyVault -kvName $config.target_name -kvSecretName $config.secret_name -kvSecretValue $token
  } elseif ($config.target -eq "k8s") {
    Set-k8sCluster -subscription $config.target_sub -resourceGroup $config.target_rg -clusterName $config.target_name -secret $token
  }
}
