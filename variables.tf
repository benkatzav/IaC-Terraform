# if a variable is not showed up here it means I defined it in tfvars file which I don't push the git repository

variable "server_location" {
  description = "Define your server location"
  type        = string
}

variable "rg_name" {
  description = "Define your resource group name"
  type        = string
}

variable "subnet_address_cidr" {
  description = "Define subnet address CIDR"
  type        = list(string)
  default     = ["CIDR defined in tfvars file"]
}

variable "admin_ip_address" {
  description = "Define your IP address"
  type        = string
  default     = "IP defined in tfvars file"
}

variable "address_range" {
  description = "Define the app's IP address range"
  type        = string
  default     = "Address range defined in tfvars file"
}

variable "pg_password" {
  description = "Define password for postgres"
  type        = string
  default     = "Password defined in tfvars file"
}

variable "admin_user" {
  description = "Admin username of the VMs that will be part of the VM scale set"
  type        = string
  default     = "admin user defined in tfvars file"
}

variable "admin_password" {
  description = "Define password for the VMs of the Scale Set"
  type        = string
  default     = "password is defined in tfvars file"
}

variable "vm_config" {
  description = "Define your VM size"
  type        = string
  default     = "Standard_B2s"
}

variable "packer_image_name" {
  description = "Define your IMG name"
  type        = string
  default     = "IMG defined in tfvars file"
}

variable "pub_key" {
  description = "Define your public key"
  type        = string
  default     = "Public key defined in tfvars file"
}

variable "packer_resource_group_name" {
  description = "Define your IMGs group name"
  type        = string
  default     = "IMGs group name defined in tfvars file"
}




