resource "azurerm_storage_account" "storage" {
  name                     = "sastreamflix${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  # Security best practices
  https_traffic_only_enabled = true
  min_tls_version            = var.min_tls_version

  # Static website configuration (useful for SPA static file storage)
  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  tags = {
    Environment = var.environment
    Project     = "StreamFlix"
  }
}
