terraform {
  required_version = "~>1.9.8"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }

  cloud {
    organization = "leriksen-experiment"
    hostname     = "app.terraform.io"
  }
}
