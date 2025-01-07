Initialising this TFC-connected codebase

1. in TFC/TFE, create a workspace with your required name
    1.    1. it should be something like `<project>_<env>` e.g. cchne_dev
1. set the value of `TF_WORKSPACE` in the [env_dev.sh file](./env-dev.sh)
    1. it should be the same as the workspace name in the above step
1. set the value of TF_VAR_env in the [env_dev.sh file](./env-dev.sh)
    1. it should be the same as the <env> suffix in `TF_WORKSPACE`
1. run `terraform init`, `terraform plan` etc
1. iterate your infra as required from there