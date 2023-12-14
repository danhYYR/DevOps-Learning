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
## Vnet
resource "azurerm_virtual_network" "demovnet" {
  name = "${var.rg_name}_demovnet"
  resource_group_name = var.rg_name
  location = var.rg_location
  address_space = var.Vnet_prefix
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
### Public IP
resource "azurerm_public_ip" "demovnet_pulicIP" {
    name = "${var.rg_name}-${azurerm_virtual_network.demovnet.name}-mydemoPulicIP"
    resource_group_name = var.rg_name
    location = var.rg_location
    allocation_method = "Static"
}