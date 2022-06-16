# Creates a LoadBalancer
resource "azurerm_lb" "lb" {
  name                = "${var.rg_name}-lb"
  location            = var.server_location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = var.app_public_ip.id
  }
}

# Creates backend pool
resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_nat_pool" "lbnatpool" {
  resource_group_name            = var.rg_name
  name                           = "ssh"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50010
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

#Create load balancer probe for port 8080
resource "azurerm_lb_probe" "lb_probe" {
  name                = "lbProbe"
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = "Http"
  port                = 8080
  interval_in_seconds = 5
  number_of_probes    = 2
  request_path        = "/"
}

#Create load balancer rule for port 8080
resource "azurerm_lb_rule" "LB_rule8080" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bpepool.id]
}
