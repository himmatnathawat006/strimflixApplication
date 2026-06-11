output "storage_account_id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.storage.name
}

output "storage_primary_web_endpoint" {
  description = "The primary web endpoint (for static website hosting if used)"
  value       = azurerm_storage_account.storage.primary_web_endpoint
}
