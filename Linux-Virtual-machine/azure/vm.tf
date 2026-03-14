locals {
  # Build only the names listed in vm_targets
  vm_set = toset([for n in var.vm_names : n if contains(var.vm_targets, n)])
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = local.vm_set            # << only vm01 today
  name                = "${var.prefix}-${each.key}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  admin_ssh_key {
    username   = var.admin_username
public_key = try(file(var.ssh_public_key_path), file("./.ssh/azure_vm_rsa.pub"))  
}

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
