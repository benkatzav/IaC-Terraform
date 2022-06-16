# IaC-Terraform
Using Terraform to build the infrastructure of the Weight Tracker application

## Infrastructure Diagram: (Treat the VMs inside the web tier as Scale Set)
![TOPOLOGY](https://user-images.githubusercontent.com/88583978/173969411-c62c8e3d-83ec-40d5-afd7-db42da983d7a.png)

## Description:
1. The Terraform template created is used to deploy the required infrastructure as defined in the diagram
2. For the Scale Set I used pre-prepared virtual machine image which already contains everything needed to run the application
3. Used PostgreSQL managed databased (flexible) that is not accessible from the internet
4. Using Auto-Scaling which increases the number of VM instances in the scale set when the load is increased (application demand increased)
5. The script also creates storage account and a container in which the Terraform state will be stored so after everything is completed you can go to providers.tf and uncomment the backend block, use the command ```terraform init``` again and the tfstate file will be saved in the container.
6. Everything is automated, once you initiate the infrastructure all you need to do is to enter one of the Scale Set virtual machines and run the ```npm run initdb``` command which connecting to the DB and creates the tables needed.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.0.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_loadbalancer"></a> [loadbalancer](#module\_loadbalancer) | ./modules/loadbalancer | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_postgres"></a> [postgres](#module\_postgres) | ./modules/postgres | n/a |
| <a name="module_vmss"></a> [vmss](#module\_vmss) | ./modules/vmss | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.bpepool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_nat_pool.lbnatpool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_pool) | resource |
| [azurerm_lb_probe.lb_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.LB_rule8080](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_linux_virtual_machine_scale_set.vmss](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.autoscale_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_network_security_group.apps_set_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.db_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_postgresql_flexible_server.postgres_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_configuration.db-config-no-ssl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_firewall_rule.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule) | resource |
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_vnl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.app_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_ssh_public_key.ssh_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/ssh_public_key) | resource |
| [azurerm_storage_account.storageacc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.tfstate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_subnet.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.app_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.db_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_image.image](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/image) | data source |
| [azurerm_resource_group.image](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_range"></a> [address\_range](#input\_address\_range) | Define the app's IP address range | `string` | `"Address range defined in tfvars file"` | no |
| <a name="input_admin_ip_address"></a> [admin\_ip\_address](#input\_admin\_ip\_address) | Define your IP address | `string` | `"IP defined in tfvars file"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Define password for the VMs of the Scale Set | `string` | `"password is defined in tfvars file"` | no |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | Admin username of the VMs that will be part of the VM scale set | `string` | `"admin user defined in tfvars file"` | no |
| <a name="input_packer_image_name"></a> [packer\_image\_name](#input\_packer\_image\_name) | Define your IMG name | `string` | `"IMG defined in tfvars file"` | no |
| <a name="input_packer_resource_group_name"></a> [packer\_resource\_group\_name](#input\_packer\_resource\_group\_name) | Define your IMGs group name | `string` | `"IMGs group name defined in tfvars file"` | no |
| <a name="input_pg_password"></a> [pg\_password](#input\_pg\_password) | Define password for postgres | `string` | `"Password defined in tfvars file"` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | Define your resource group name | `string` | n/a | yes |
| <a name="input_server_location"></a> [server\_location](#input\_server\_location) | Define your server location | `string` | n/a | yes |
| <a name="input_subnet_address_cidr"></a> [subnet\_address\_cidr](#input\_subnet\_address\_cidr) | Define subnet address CIDR | `list(string)` | n/a | no |
| <a name="input_vm_config"></a> [vm\_config](#input\_vm\_config) | Define your VM size | `string` | `"Standard_B2s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vmss_password"></a> [vmss\_password](#output\_vmss\_password) | n/a |
