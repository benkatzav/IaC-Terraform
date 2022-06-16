# Here are some outputs we need to share with the other modules

output "apps_set_nsg" {
  value = azurerm_network_security_group.apps_set_nsg
}

output "apps_subnet" {
  value = azurerm_subnet.public
}

output "db_subnet" {
  value = azurerm_subnet.private
}

output "vnet" {
  value = azurerm_virtual_network.vnet
}

output "app_public_ip" {
  value = azurerm_public_ip.app_public_ip
}
