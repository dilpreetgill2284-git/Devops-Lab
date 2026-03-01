variable "location" {
  description = "Azure region"
  type        = string
  default     = "australiaeast"
}

variable "rg_name" {
  description = "Resource Group name"
  type        = string
}

variable "storage_account_name" {
  description = "Globally-unique SA name (3–24 lowercase letters/numbers)"
  type        = string
}

variable "container_name" {
  description = "Blob container name (lowercase, no spaces; hyphens allowed)"
  type        = string
}

variable "blob_name" {
  description = "Blob object name as it will appear in the container"
  type        = string
}

variable "blob_source" {
  description = "Local file path to upload"
  type        = string
}
