# Here are some outputs we need to share with the other modules

output "bpepool" {
  value = azurerm_lb_backend_address_pool.bpepool
}

output "lbnatpool" {
  value = azurerm_lb_nat_pool.lbnatpool
}