output "public_ip_id" {
  description = "The ID of the Public IP"
  value       = azurerm_public_ip.pip.id
}

output "public_ip_address" {
  description = "The IP address value of the Public IP"
  value       = azurerm_public_ip.pip.ip_address
}
