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
output "public_IP" {
  description = "The pulic IP "
  value       = module.vnet.public_IP
}
output "sp-object_id" {
  description = "The object_id of the service principal. Can used to assign role for user"
  value = module.ServicePrincipal.sp-object_id
}
output "tennet_id" {
  value = module.ServicePrincipal.tennet_id
}
output "application_id" {
  value = module.ServicePrincipal.application_id
}

output "client_secret" {
  value = module.ServicePrincipal.client_secret
  sensitive = true
}
output "aks-demo" {
  value = module.aks-cluster.aks_id
}