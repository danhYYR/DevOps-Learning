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
    template = {
      source = "hashicorp/template"
      version = ">=2.0.0"
    }
  }
  backend "azurerm" {
    # resource_group_name   = var.grp_name
    # storage_account_name  = var.sa_name
    # container_name        = var.sa_container_name
    # key                   = var.sa_key
  }
  required_version = ">=1.0.0"
}
# Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
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
  aks_vnet_address = var.aks_subnet_address
  aks_subnet_address = var.aks_subnet_address
  aks_subnet_name = var.aks_subnet_name
}
## Service Principal
module "ServicePrincipal" {
  source = "./modules/ServicePrincipal"
  vnet_id = module.vnet.aks-vnet_id
  aks_id = module.aks-cluster.aks_id
  sp-name = "aks-serviceprincipal"
}
# AKS
## aks-cluster
module "aks-cluster" {
  source = "./modules/akscluster"
  rg_name = azurerm_resource_group.demotf.name
  rg_location = azurerm_resource_group.demotf.location
  aks_name = var.aks_name
  CP_AKS_ID = module.vnet.CP_subnet_id
  Cluster_AKS_ID = module.vnet.Cluster_subnet_id
  client_id = module.ServicePrincipal.client_id
  client_secret = module.ServicePrincipal.client_secret
  # depends_on = [ module.jumhost ]
}
## JumpHostVM
module "jumhost" {
  source = "./modules/jumphost"
  rg_name = azurerm_resource_group.demotf.name
  rg_location = azurerm_resource_group.demotf.location
  admin_username = "admin_jp"
  ssh_public_key = var.ssh_public_key
  vnet_subnet_id = module.vnet.JP_subnet_id
  publicip_name= module.vnet.publicip_name
  depends_on = [azurerm_resource_group.demotf,module.vnet]
}
