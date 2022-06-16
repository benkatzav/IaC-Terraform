# Configure the Azure provider
terraform {
  # The following backend block is used in order to store the Terraform state in Azure Blob Storage
  # In case this is the first init please comment the backend block
  # For the reason that the storage account has not been created yet

  backend "azurerm" {
    resource_group_name  = "weight-tracker"
    storage_account_name = "benkatzavstoragetfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}