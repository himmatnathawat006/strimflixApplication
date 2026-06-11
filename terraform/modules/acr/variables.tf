variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "environment" {
  description = "The deployment environment"
  type        = string
}

variable "sku" {
  description = "The SKU of the Container Registry (e.g. Basic, Standard, Premium)"
  type        = string
}

variable "admin_enabled" {
  description = "Whether the admin login is enabled"
  type        = bool
}
