resource "azurerm_container_registry" "acr" {
  name                = "acrstreamflix${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  tags = {
    Environment = var.environment
    Project     = "StreamFlix"
  }
}
