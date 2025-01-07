module "globals" {
  source = "../globals"
}

locals {
  env_sub = {
    dev = "NP"
    prd = "P"
  }

  kv_writers = {
    dev = [
      "00e67771-2882-40d1-a0c4-899f624ea97d",
    ]
  }
}

module "subscription" {
  source = "../subscription"
  subscription = local.env_sub[var.environment]
}


