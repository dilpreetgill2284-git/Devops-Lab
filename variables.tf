variable "location" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "Australia East"
}

variable "prefix" {
  type        = string
  description = "Short prefix for naming Azure resources"
  default     = "dil"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Full path to your SSH public key (.pub). Must include the filename."
  default     = "C:/Terraform/LinuxVMHomework/Keys/azure_vm_rsa.pub"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the VNet"
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "Address prefixes for the subnet"
  default     = ["10.0.2.0/24"]
}

variable "vm_size" {
  type        = string
  description = "Cheapest option availbe for labs is Standard_B2als_v2"
  default     = "Standard_B2als_v2"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the Linux VM"
  default     = "adminuser"
}

variable "subnet_name" {
  type        = string
  description = "Name for the subnet resource in the VNet"
  default     = "vm-subnet"
}

variable "nic_ipconfig_name" {
  type        = string
  description = "Name for the NIC's IP configuration block"
  default     = "nic-ipconfig"
}


variable "vm_names" {
  type    = set(string)
  default = ["vm01", "vm02"]
}