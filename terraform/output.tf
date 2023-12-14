# Output Values - Resource Group
output "rg_id" {
  description = "Resource Group ID"
  # Atrribute Reference
  value = azurerm_resource_group.demotf.id
}
output "rg_name" {
  description = "Resource Group name"
  # Argument Reference
  value = azurerm_resource_group.demotf.name
}
## Vnet
output "vnet_name" {
  description = "Specifies the name of the virtual network"
  value       = module.hub_network.name
}

output "vnet_id" {
  description = "Specifies the resource id of the virtual network"
  value       = module.hub_network.id
}

output "vnet_subnet_ids" {
  description = "Contains a list of the the resource id of the subnets"
  value       = module.hub_network.ids
}

output "public_IP" {
  description = "The pulic IP "
  value       = module.hub_network.public_IP
}