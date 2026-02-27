# outputs.tf

# VM IDs keyed by vm name (e.g., vm01, vm02)
output "vm_ids" {
  description = "VM IDs keyed by vm name"
  value = {
    for name, inst in azurerm_linux_virtual_machine.vm :
    name => inst.id
  }
}

# NIC private IPs keyed by vm name
output "nic_private_ips" {
  description = "NIC private IPs keyed by vm name"
  value = {
    for name, nic in azurerm_network_interface.nic :
    name => nic.ip_configuration[0].private_ip_address
  }
}

# Public IPs keyed by vm name (only if your Public IP resource also uses for_each = var.vm_names)
output "public_ips" {
  description = "Public IPs keyed by vm name"
  value = {
    for name, pip in azurerm_public_ip.public_ip :
    name => pip.ip_address
  }
}