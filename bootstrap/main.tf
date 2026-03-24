terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "8d9e4373-f610-460e-8c58-e1dc091ba829"
  storage_use_azuread = true
}

resource "azurerm_resource_group" "state" {
  name     = "rg-tfstate"
  location = "westeurope"
}

resource "azurerm_storage_account" "state" {
  name                     = "savpnuk8689"
  resource_group_name      = azurerm_resource_group.state.name
  location                 = azurerm_resource_group.state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "tfstate_blob" {
  scope                = azurerm_storage_account.state.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_storage_container" "state" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.state.name
  container_access_type = "private"
}