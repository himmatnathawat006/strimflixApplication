variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the existing Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure Region to deploy resources"
  type        = string
}

variable "environment" {
  description = "The environment name"
  type        = string
}

# VNet variables
variable "vnet_address_space" {
  description = "VNet address space list"
  type        = list(string)
}

variable "vnet_subnets" {
  description = "Map of subnets to create dynamically"
  type = map(object({
    name           = string
    address_prefix = string
  }))
}

# ACR variables
variable "acr_sku" {
  description = "Registry SKU size"
  type        = string
}

variable "acr_admin_enabled" {
  description = "Enable registry admin login credentials"
  type        = bool
}

# AKS variables
variable "aks_dns_prefix" {
  description = "DNS prefix for the cluster control plane"
  type        = string
}

variable "aks_system_node_pool" {
  description = "Default system pool configurations"
  type = object({
    name            = string
    node_count      = number
    vm_size         = string
    os_disk_size_gb = number
  })
}

variable "aks_user_node_pools" {
  description = "Map of user node pools to scale dynamically"
  type = map(object({
    vm_size              = string
    auto_scaling_enabled = bool
    min_count            = number
    max_count            = number
    node_count           = number
    os_disk_size_gb      = number
    node_labels          = map(string)
  }))
}

variable "aks_network_profile" {
  description = "Cluster network profiles"
  type = object({
    network_plugin    = string
    network_policy    = string
    load_balancer_sku = string
  })
}

# Key Vault variables
variable "kv_sku_name" {
  description = "Key Vault SKU tier"
  type        = string
}

variable "kv_soft_delete_retention_days" {
  description = "Key Vault soft delete preservation duration"
  type        = number
}

variable "kv_purge_protection_enabled" {
  description = "Enable Key Vault purge protection rules"
  type        = bool
}

# SQL Server variables
variable "sql_admin_username" {
  description = "Database admin username"
  type        = string
}

variable "sql_admin_password" {
  description = "Database admin password credential"
  type        = string
  sensitive   = true
}

variable "sql_databases" {
  description = "Map of databases schemas to create dynamically"
  type = map(object({
    collation      = string
    license_type   = string
    max_size_gb    = number
    sku_name       = string
    zone_redundant = bool
  }))
}

# Storage variables
variable "storage_account_tier" {
  description = "Storage account tier configuration"
  type        = string
}

variable "storage_replication_type" {
  description = "Storage account replication mode"
  type        = string
}

variable "storage_min_tls_version" {
  description = "Storage account minimal TLS version restriction"
  type        = string
}

# Public IP variables
variable "pip_allocation_method" {
  description = "Static IP allocation strategy"
  type        = string
}

variable "pip_sku" {
  description = "Static IP SKU type"
  type        = string
}
