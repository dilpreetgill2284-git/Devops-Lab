terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

locals {
  rg_name  = "RG-KeyVault-Homework"
  kv_name  = "kv-homework"
  location = "australiaeast"
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = local.location
}

resource "azurerm_key_vault" "kv" {
  name                = local.kv_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = "standard"

  enable_rbac_authorization   = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
}

resource "azurerm_role_assignment" "kv_admin_self" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

output "key_vault_name" { value = azurerm_key_vault.kv.name }
output "key_vault_uri"  { value = azurerm_key_vault.kv.vault_uri }
