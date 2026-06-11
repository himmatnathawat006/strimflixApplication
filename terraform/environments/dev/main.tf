# Reference the existing Resource Group Himmat-RG
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Module 1: Virtual Network (VNet) & Subnets (Subnets created via for_each)
module "vnet" {
  source              = "../../modules/vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  environment         = var.environment
  address_space       = var.vnet_address_space
  subnets             = var.vnet_subnets
}

# Module 2: Azure Container Registry (ACR)
module "acr" {
  source              = "../../modules/acr"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  environment         = var.environment
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled
}

# Module 3: Key Vault & User-Assigned Managed Identity
module "keyvault" {
  source                     = "../../modules/keyvault"
  resource_group_name        = data.azurerm_resource_group.rg.name
  location                   = data.azurerm_resource_group.rg.location
  environment                = var.environment
  sku_name                   = var.kv_sku_name
  soft_delete_retention_days = var.kv_soft_delete_retention_days
  purge_protection_enabled   = var.kv_purge_protection_enabled
}

# Module 4: Azure SQL Server & Databases (Databases created via for_each)
module "database" {
  source              = "../../modules/database"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  environment         = var.environment
  sql_admin_username  = var.sql_admin_username
  sql_admin_password  = var.sql_admin_password
  databases           = var.sql_databases
}

# Module 5: Storage Account
module "storage" {
  source                   = "../../modules/storage"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  environment              = var.environment
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type
  min_tls_version          = var.storage_min_tls_version
}

# Module 6: Static Public IP (for ingress controller)
module "publicip" {
  source              = "../../modules/publicip"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  environment         = var.environment
  allocation_method   = var.pip_allocation_method
  sku                 = var.pip_sku
}

# Module 7: Azure Kubernetes Service (AKS) (User node pools created via for_each)
module "aks" {
  source              = "../../modules/aks"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  environment         = var.environment
  # Resolve user subnet ID dynamically from VNet module map output
  vnet_subnet_id   = module.vnet.subnet_ids["user"]
  dns_prefix       = var.aks_dns_prefix
  system_node_pool = var.aks_system_node_pool
  user_node_pools  = var.aks_user_node_pools
  network_profile  = var.aks_network_profile
}

# Role Assignment: Allow AKS to pull images from ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = module.aks.kubelet_identity_object_id
  role_definition_name             = "AcrPull"
  scope                            = module.acr.acr_id
  skip_service_principal_aad_check = true
}

# Role Assignment: Allow User-Assigned Managed Identity to read secrets from Key Vault
resource "azurerm_role_assignment" "identity_kv_secrets_user" {
  principal_id         = module.keyvault.managed_identity_principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = module.keyvault.keyvault_id
}
