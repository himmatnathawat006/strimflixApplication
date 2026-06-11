output "keyvault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.kv.id
}

output "keyvault_uri" {
  description = "The vault URI of the Key Vault"
  value       = azurerm_key_vault.kv.vault_uri
}

output "managed_identity_id" {
  description = "The ID of the User Assigned Identity"
  value       = azurerm_user_assigned_identity.identity.id
}

output "managed_identity_principal_id" {
  description = "The Principal ID of the User Assigned Identity"
  value       = azurerm_user_assigned_identity.identity.principal_id
}

output "managed_identity_client_id" {
  description = "The Client ID of the User Assigned Identity"
  value       = azurerm_user_assigned_identity.identity.client_id
}
