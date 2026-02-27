variable "location" { # kept for compatibility; we always use the RG's location in resources
  type        = string
  description = "Azure region (RG location is authoritative)."
  default     = "australiaeast"
}

variable "resource_group_name" {
  type        = string
  description = "Existing Resource Group name."
}

variable "prefix" {
  type        = string
  description = "Prefix for resource names (set by CI)"
  default     = "devops-lab"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the VNet."
  default     = ["10.10.0.0/16"]
}

variable "subnet_name" {
  type        = string
  description = "Subnet name."
  default     = "snet-devops-lab"
}

variable "subnet_cidr" {
  type        = string
  description = "Subnet CIDR."
  default     = "10.10.1.0/24"
}

variable "vm_names" {
  type        = set(string)
  description = "Set of VM names for for_each."
  default     = ["vm-devops-01", "vm-devops-02"]
}

variable "vm_size" {
  type        = string
  description = "VM size."
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  type        = string
  description = "SSH admin username."
  default     = "azureuser"
}

variable "ssh_public_key" {
  type        = string
  description = "Optional OpenSSH public key string. If empty, keypair is generated."
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags."
  default = {
    environment = "dev"
    owner       = "devops-lab"
  }
}
