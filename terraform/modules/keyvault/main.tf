data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                       = "kv-streamflix-${var.environment}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.sku_name
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  # Enable Azure RBAC authorization so roles can be assigned on the vault
  rbac_authorization_enabled = true

  tags = {
    Environment = var.environment
    Project     = "StreamFlix"
  }
}

# User Assigned Managed Identity for Pod Workload Identity
resource "azurerm_user_assigned_identity" "identity" {
  name                = "id-streamflix-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    Environment = var.environment
    Project     = "StreamFlix"
  }
}

# Role assignment for Terraform service principal / deployer itself to allow managing Key Vault (RBAC)
resource "azurerm_role_assignment" "deployer" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

