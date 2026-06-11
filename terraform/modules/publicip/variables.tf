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

variable "allocation_method" {
  description = "The allocation method of the public IP (Static or Dynamic)"
  type        = string
}

variable "sku" {
  description = "The SKU of the public IP (Basic or Standard)"
  type        = string
}
