# Terraform source
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name   = "demogrp"
    storage_account_name  = "tfstate22801"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
  required_version = ">=1.0.0"
}
# Provider
provider "azurerm" {
  features {}
}
# Resource
## Resource Group
resource "azurerm_resource_group" "demotf" {
  name     = var.rg_name
  location = var.rg_location
}
## Vnet
module "hub_network" {
  source              = "./modules/vnet"
  rg_name             = azurerm_resource_group.demotf.name
  rg_location         = azurerm_resource_group.demotf.location
  Vnet_prefix         = var.Vnet_prefix
  Vnet_subnet_name    = var.Vnet_subnet_name
  Vnet_subnet_address = var.Vnet_subnet_address
}
