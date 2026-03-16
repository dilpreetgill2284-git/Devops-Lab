data "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-dil"
  resource_group_name = "rg-dil-aks"
}
