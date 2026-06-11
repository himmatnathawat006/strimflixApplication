resource "azurerm_public_ip" "pip" {
  name                = "pip-streamflix-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.sku

  tags = {
    Environment = var.environment
    Project     = "StreamFlix"
  }
}
