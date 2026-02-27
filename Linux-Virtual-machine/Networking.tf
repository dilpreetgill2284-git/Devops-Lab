# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-network"
  address_space       = var.vnet_address_space
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  for_each            = var.vm_names
  name                = "${var.prefix}-nic-${each.key}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = contains(keys(azurerm_public_ip.public_ip), each.key) ? azurerm_public_ip.public_ip[each.key].id : null
  }
}
