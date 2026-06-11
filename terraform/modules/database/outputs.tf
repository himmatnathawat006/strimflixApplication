output "sql_server_name" {
  description = "The name of the SQL Server"
  value       = azurerm_mssql_server.sql.name
}

output "sql_server_fqdn" {
  description = "The fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
}

output "sql_database_ids" {
  description = "A map of database names to their IDs"
  value       = { for k, v in azurerm_mssql_database.db : k => v.id }
}
