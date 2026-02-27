resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-network"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}

# Only one Public IP, for vm-devops-01 (avoid quota issues)
resource "azurerm_public_ip" "public_ip" {
  for_each            = { for n in tolist(var.vm_names) : n => n if n == "vm-devops-01" }
  name                = "${var.prefix}-pip-${each.key}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vm_names
  name                = "${var.prefix}-nic-${each.key}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = var.tags

  # Ensure NICs wait for the PIP set (even though only one PIP exists)
  depends_on = [azurerm_public_ip.public_ip]

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"

    # Attach PIP only if one exists for this VM (vm-devops-01). Others get null.
    public_ip_address_id = contains(keys(azurerm_public_ip.public_ip), each.key) ? azurerm_public_ip.public_ip[each.key].id : null
  }
}
