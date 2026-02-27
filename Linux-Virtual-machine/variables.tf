variable "location" {
  type        = string
  description = "Azure region"
  default     = "australiaeast"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "vnet_name" {
  type        = string
  description = "VNet name"
}

variable "vnet_cidr" {
  type        = string
  description = "VNet CIDR"
  default     = "10.10.0.0/16"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "subnet_cidr" {
  type        = string
  description = "Subnet CIDR"
  default     = "10.10.1.0/24"
}

variable "vm_name" {
  type        = string
  description = "Base VM name"
  default     = "vm-devops-01"
}

variable "vm_size" {
  type        = string
  description = "VM size"
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Admin username"
  default     = "azureuser"
}

/* Remove the hard requirement for ssh_public_key:
   - Either don't declare it at all, OR declare with empty default.
*/
variable "ssh_public_key" {
  type        = string
  description = "Optional public key string; if empty, Terraform will generate one"
  default     = ""
}
``
