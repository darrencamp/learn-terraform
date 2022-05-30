# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  backend "azurerm" {
    resource_group_name  = "Development"
    storage_account_name = "cidevtf01"
    container_name       = "learn-terraform-tfstate"
    key                  = "terraform.tfstate"
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.default_location
  tags = {
    Purpose = "learn"
  }
}

resource "azurerm_storage_account" "primary" {
  name                     = "aucid01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Purpose = "learn"
  }
}

resource "azurerm_storage_container" "audit" {
  name                  = "request-audit-records"
  storage_account_name  = azurerm_storage_account.primary.name
  container_access_type = "private"
}

