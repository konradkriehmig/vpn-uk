terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "savpnuk8689"
    container_name       = "tfstate"
    key                  = "vpn.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
  subscription_id     = "ARM_SUBSCRIPTION_ID"
  storage_use_azuread = true
}