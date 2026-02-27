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

