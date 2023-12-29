output name {
  description = "Specifies the name of the virtual network"
  value       = azurerm_virtual_network.demovnet.name
}

output vnet_id {
  description = "Specifies the resource id of the virtual network"
  value       = azurerm_virtual_network.demovnet.id
}

output subnet_ids {
    description = "Contains a list of the the resource id of the subnets"
    value       = { for i, subnet in azurerm_subnet.demovnet_subnet : i => subnet.id}
}

output publicip_id{
    description = "The pulic IP "
    value = azurerm_public_ip.demovnet_pulicIP.id
}
output publicip_ipaddress{
    description = "The pulic IP address"
    value = azurerm_public_ip.demovnet_pulicIP.ip_address
}
# AKS-VNet
output "aks-vnet_id" {
  description = "The Vnet to manage the AKS"
  value = azurerm_virtual_network.demovnet_aks.id
}
output CP_subnet_id {
  description = "The Vnet to manage the Control Plane on AKS"
  value = azurerm_subnet.demovnet_aks_cp.id
}
output Cluster_subnet_id {
  description = "The Cluster subnet for AKS"
  value = azurerm_subnet.demovnet_aks_cluster.id
}
output "JP_subnet_id" {
  description = "The Cluster subnet for AKS"
  value = azurerm_subnet.demovnet_aks_jpvm.id  
}