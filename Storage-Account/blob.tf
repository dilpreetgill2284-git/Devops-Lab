resource "azurerm_storage_blob" "blob" {
  name                   = var.blob_name
  storage_account_name   = azurerm_storage_account.st.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source                 = var.blob_source
}
