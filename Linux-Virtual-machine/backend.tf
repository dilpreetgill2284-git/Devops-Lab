terraform {
  backend "azurerm" {
    resource_group_name  = "rg-dil-storage"        # The RG that holds your storage account
    storage_account_name = "dilstorage123456"      # Your storage account (already created)
    container_name       = "blob-container"        # Your container (already created)
    key                  = "linuxvm/terraform.tfstate"  # The blob name for tfstate (Terraform will create this)
  }
}

provider "azurerm" {
  features {}
}
