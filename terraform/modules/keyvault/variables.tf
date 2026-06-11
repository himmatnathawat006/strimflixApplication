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

variable "sku_name" {
  description = "The SKU of the Key Vault (standard or premium)"
  type        = string
}

variable "soft_delete_retention_days" {
  description = "The number of days to retain soft deleted keys/secrets"
  type        = number
}

variable "purge_protection_enabled" {
  description = "Whether purge protection is enabled on the vault"
  type        = bool
}
