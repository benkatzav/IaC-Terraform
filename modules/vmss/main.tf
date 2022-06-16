# Importing the existing resource group which stores the VM image
data "azurerm_resource_group" "image" {
  name = var.packer_resource_group_name
}

# The image we're going to use which already contains our application with it
data "azurerm_image" "image" {
  name                = var.packer_image_name
  resource_group_name = data.azurerm_resource_group.image.name
}

# Creating the VMs Scale Set
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = "scale-machine"
  admin_username                  = var.admin_user
  instances                       = 2
  location                        = var.server_location
  resource_group_name             = var.rg_name
  sku                             = var.vm_config
  upgrade_mode                    = "Automatic"
  disable_password_authentication = false
  depends_on                      = [var.apps_set_nsg]
  admin_password                  = var.admin_password

  network_interface {
    name                      = "netInterface"
    primary                   = true
    network_security_group_id = var.apps_set_nsg.id
    ip_configuration {
      name                                   = "publicIP"
      load_balancer_backend_address_pool_ids = [var.bpepool.id]
      load_balancer_inbound_nat_rules_ids    = [var.lbnatpool.id]
      subnet_id                              = var.apps_subnet.id
      primary                                = true
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_id = data.azurerm_image.image.id

  // NEXT BLOCK IS FOR REPLACING IMG WITH CLEAN UBUNTU IMG
  /*
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  */
}

# Defining scaling rules
resource "azurerm_monitor_autoscale_setting" "autoscale_setting" {
  location            = var.server_location
  name                = "autoscale_setting"
  resource_group_name = var.rg_name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss.id
  depends_on          = [azurerm_linux_virtual_machine_scale_set.vmss]
  profile {
    name = "AutoScale"
    capacity {
      default = 3
      maximum = 5
      minimum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        operator           = "GreaterThan"
        statistic          = "Average"
        threshold          = 75
        time_aggregation   = "Average"
        time_grain         = "PT1M"
        time_window        = "PT5M"
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
      }
      scale_action {
        cooldown  = "PT1M"
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
      }
    }
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}
