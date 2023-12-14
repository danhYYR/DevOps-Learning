output name {
  description = "Specifies the name of the virtual network"
  value       = azurerm_virtual_network.demovnet.name
}

output id {
  description = "Specifies the resource id of the virtual network"
  value       = azurerm_virtual_network.demovnet.id
}

output ids {
    description = "Contains a list of the the resource id of the subnets"
    value       = { for i, subnet in azurerm_subnet.demovnet_subnet : i => subnet.id}
}

output public_IP {
    description = "The pulic IP "
    value = azurerm_public_ip.demovnet_pulicIP
}