# Terraform source
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.0" 
    }
    azuread = {
      source  = "hashicorp/azuread"
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
provider "azuread" {}
# Resource
## Resource Group
resource "azurerm_resource_group" "demotf" {
  name     = var.rg_name
  location = var.rg_location
}

## Vnet
module "vnet" {
  source              = "./modules/vnet"
  rg_name             = azurerm_resource_group.demotf.name
  rg_location         = azurerm_resource_group.demotf.location
  Vnet_prefix         = var.Vnet_prefix
  Vnet_subnet_name    = var.Vnet_subnet_name
  Vnet_subnet_address = var.Vnet_subnet_address
  aks_subnet_name = var.aks_subnet_name
  aks_subnet_address = var.aks_subnet_address
}
## Service Principal
module "ServicePrincipal" {
  source = "./modules/ServicePrincipal"
  Cluster_id = module.vnet.Cluster_Vnet_id
  CP_id = module.vnet.CP_Vnet_id
  sp-name = "aks-serviceprincipal"
}
## aks-cluster
module "aks-cluster" {
  source = "./modules/akscluster"
  rg_name = azurerm_resource_group.demotf.name
  rg_location = azurerm_resource_group.demotf.location
  aks_name = var.aks_name
  CP_AKS_ID = module.vnet.CP_Vnet_id
  CP_AKS_RANGE = ["${element(var.aks_subnet_address,index(var.aks_subnet_name,"ControlPlane"))}"]
  Cluster_AKS_ID = module.vnet.Cluster_Vnet_id
  Cluster_AKS_RANGE = ["${element(var.aks_subnet_address,index(var.aks_subnet_name,"Cluster"))}"]
  client_id = module.ServicePrincipal.client_id
  client_secret = module.ServicePrincipal.client_secret
}
