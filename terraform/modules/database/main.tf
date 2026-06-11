resource "azurerm_mssql_server" "sql" {
  name                         = "sql-streamflix-${var.environment}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"

  tags = {
    Environment = var.environment
    Project     = "StreamFlix"
  }
}

resource "azurerm_mssql_database" "db" {
  for_each       = var.databases
  name           = each.key
  server_id      = azurerm_mssql_server.sql.id
  collation      = each.value.collation
  license_type   = each.value.license_type
  max_size_gb    = each.value.max_size_gb
  sku_name       = each.value.sku_name
  zone_redundant = each.value.zone_redundant

  tags = {
    Environment = var.environment
    Project     = "StreamFlix"
  }
}

# Firewall rule allowing traffic from internal Azure services (including AKS) to reach the SQL server
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
