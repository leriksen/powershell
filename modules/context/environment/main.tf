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
      "00e67771-2882-40d1-a0c4-899f624ea97d", # me
      "1b046833-25d7-4088-9827-024a1f646b32", # azdo fed id
    ]
    prd = []
  }

  acr_pushers = {
    dev = [
      "00e67771-2882-40d1-a0c4-899f624ea97d", # me
      "1b046833-25d7-4088-9827-024a1f646b32", # azdo fed id
    ]
    prd = []
  }
}

module "subscription" {
  source = "../subscription"
  subscription = local.env_sub[var.environment]
}


