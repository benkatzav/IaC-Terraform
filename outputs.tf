output "vmss_password" {
  value     = module.vmss.vmss_password
  sensitive = true
}