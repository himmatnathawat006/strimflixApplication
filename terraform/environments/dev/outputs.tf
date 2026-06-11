output "resource_group_name" {
  value = var.resource_group_name
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "aks_cluster_name" {
  value = module.aks.cluster_name
}

output "aks_kubelet_identity_client_id" {
  value = module.aks.kubelet_identity_client_id
}

output "keyvault_uri" {
  value = module.keyvault.keyvault_uri
}

output "managed_identity_client_id" {
  value = module.keyvault.managed_identity_client_id
}

output "sql_server_fqdn" {
  value = module.database.sql_server_fqdn
}

output "sql_database_ids" {
  value = module.database.sql_database_ids
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "storage_primary_web_endpoint" {
  value = module.storage.storage_primary_web_endpoint
}

output "public_ip_address" {
  value = module.publicip.public_ip_address
}
