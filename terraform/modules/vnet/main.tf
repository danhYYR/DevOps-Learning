# Terraform source
terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">=2.0.0"
    }
  }
  required_version = ">=1.0.0"
}
# Provider
provider "azurerm" {
  features {}
}
# Resource
## Vnet for worker node
resource "azurerm_virtual_network" "demovnet" {
  name = "${var.rg_name}_demovnet"
  resource_group_name = var.rg_name
  location = var.rg_location
  address_space = var.Vnet_prefix
}
resource "azurerm_virtual_network" "demovnet_aks" {
  name = "AKS_aks"
  resource_group_name = var.rg_name
  location = var.rg_location
  address_space = ["172.0.0.0/16"]
}
### Subnet
resource "azurerm_subnet" "demovnet_subnet" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet.name
    count = length(var.Vnet_subnet_address)
    name = "${element(var.Vnet_subnet_name,count.index)}"
    address_prefixes = [element(var.Vnet_subnet_address,count.index)]
    depends_on = [ azurerm_virtual_network.demovnet ]
}
resource "azurerm_subnet" "demovnet_aks_cp" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet_aks.name
    name = "Apiserver"
    address_prefixes = [element(var.aks_subnet_address,index(var.aks_subnet_name,"ControlPlane"))]
    delegation {
      name = "AKS api-server"
      service_delegation {
        name = "Microsoft.ContainerService/managedClusters"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      }
    }
}
resource "azurerm_subnet" "demovnet_aks_cluster" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet_aks.name
    name = "Cluster-Vnet"
    address_prefixes = [element(var.aks_subnet_address,index(var.aks_subnet_name,"Cluster"))]
}
### Public IP
resource "azurerm_public_ip" "demovnet_pulicIP" {
    name = "${var.rg_name}-${azurerm_virtual_network.demovnet.name}-mydemoPulicIP"
    resource_group_name = var.rg_name
    location = var.rg_location
    allocation_method = "Static"
}
