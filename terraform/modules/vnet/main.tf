# Vnet for Jumhost VM
resource "azurerm_virtual_network" "demovnet" {
  name = "${var.rg_name}_demovnet"
  resource_group_name = var.rg_name
  location = var.rg_location
  address_space = var.Vnet_prefix
}

## Subnet
resource "azurerm_subnet" "demovnet_subnet" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet.name
    count = length(var.Vnet_subnet_address)
    name = "${element(var.Vnet_subnet_name,count.index)}"
    address_prefixes = [element(var.Vnet_subnet_address,count.index)]
    depends_on = [ azurerm_virtual_network.demovnet ]
}
## AKS VNet
resource "azurerm_virtual_network" "demovnet_aks" {
  name = "aks-vnet"
  resource_group_name = var.rg_name
  location = var.rg_location
  address_space = var.aks_vnet_address
}
resource "azurerm_subnet" "demovnet_aks_cp" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet_aks.name
    name = "Apiserver"
    address_prefixes = [element(var.aks_subnet_address,index(var.aks_subnet_name,"controlplane"))]
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
    address_prefixes = [element(var.aks_subnet_address,index(var.aks_subnet_name,"cluster"))]
}

resource "azurerm_subnet" "demovnet_aks_jpvm" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet_aks.name
    name = "JP_VM-Vnet"
    address_prefixes = [element(var.aks_subnet_address,index(var.aks_subnet_name,"jumphost-vm"))]
}

## Public IP
resource "azurerm_public_ip" "demovnet_pulicIP" {
    name = "${var.rg_name}-mydemoPulicIP"
    resource_group_name = var.rg_name
    location = var.rg_location
    allocation_method = "Static"
}