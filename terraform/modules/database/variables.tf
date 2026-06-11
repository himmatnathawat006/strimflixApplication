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

variable "sql_admin_username" {
  description = "The SQL Server administrator username"
  type        = string
}

variable "sql_admin_password" {
  description = "The SQL Server administrator password"
  type        = string
  sensitive   = true
}

variable "databases" {
  description = "A map of databases to create under the SQL server"
  type = map(object({
    collation      = string
    license_type   = string
    max_size_gb    = number
    sku_name       = string
    zone_redundant = bool
  }))
}
