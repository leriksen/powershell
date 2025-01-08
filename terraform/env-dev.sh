echo "Show account list"
az account list --refresh 2>/dev/null

echo "set TFC workspace to connect to"

export TF_WORKSPACE="tokenrefreshdev"
export TF_VAR_env="dev"

echo "workspace == ${TF_WORKSPACE}"
echo "TF_VAR_env == ${TF_VAR_env}"

