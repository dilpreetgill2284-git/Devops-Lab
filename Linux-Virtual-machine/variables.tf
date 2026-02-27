variable "location" {
  type        = string
  description = "Azure region for all resources."
  default     = "australiaeast"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group to create/use."
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network."
}

variable "vnet_cidr" {
  type        = string
  description = "CIDR for the Virtual Network."
  default     = "10.10.0.0/16"
}

variable "subnet_name" {
  type        = string
  description = "Name of the Subnet."
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR for the Subnet."
  default     = "10.10.1.0/24"
}

variable "vm_name" {
  type        = string
  description = "Base VM name. You can suffix/index this in resources."
  default     = "vm-devops-01"
}

variable "vm_size" {
  type        = string
  description = "Azure VM size."
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Admin username for SSH."
  default     = "azureuser"
}

# Optional: if empty, ssh.tf should generate a key and use its public key.
variable "ssh_public_key" {
  type        = string
  description = "Optional OpenSSH public key string. If empty, Terraform-generated key will be used."
  default     = ""
}

# Present because other files use ${var.prefix}-... naming.
variable "prefix" {
  type        = string
  description = "Prefix for naming resources (used by VM/NIC/NSG/PIP/etc.)."
  default     = "devops-lab"
}

# Optional: only if you create multiple VMs/NICs with for_each/count in your code.
variable "vm_count" {
  type        = number
  description = "Number of VMs to create (used only if referenced in resources)."
  default     = 2
}

# Optional tags for all supported resources
variable "tags" {
  type        = map(string)
  description = "Common tags to apply to resources."
  default = {
    environment = "dev"
    owner       = "devops-lab"
  }
}

# Used by azurerm_virtual_network.address_space (list(string))
variable "vnet_address_space" {
  type        = list(string)
  description = "Address space list for the VNet."
  default     = ["10.10.0.0/16"]
}

# Used by for_each across resources when naming with each.key
variable "vm_names" {
  type        = set(string)
  description = "Set of VM names used for for_each across resources."
  default     = ["vm-devops-01", "vm-devops-02"]
}
