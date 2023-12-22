# Resource group
rg_name = "demogrptf"
rg_location = "eastasia"
# Vnet define
aks_vnet_address = [ "172.0.0.0/16"]
aks_subnet_address = [ "172.0.244.0/24","172.0.0.0/24","172.0.5.0/24"]
aks_subnet_name = ["cluster","controlplane","jumphost-vm"]
# Aks define
aks_name = "aks-demo"
