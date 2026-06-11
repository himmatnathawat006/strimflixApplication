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

variable "account_tier" {
  description = "The Tier of the storage account (Standard or Premium)"
  type        = string
}

variable "account_replication_type" {
  description = "The replication type of the storage account (LRS, GRS, etc.)"
  type        = string
}

variable "min_tls_version" {
  description = "The minimum TLS version supported (e.g. TLS1_2)"
  type        = string
}
