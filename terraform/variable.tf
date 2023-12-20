# Resoure group
variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
  default     = "demogrptf"
}
variable "rg_location" {
  description = "The Resource Group location"
  type        = string
  default     = "centralindia"
}

variable "Vnet_prefix" {
  description = "Set up the Vnet Prefix range"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}
variable "Vnet_subnet_name" {
  description = "The subnet name in the Virtual Network"
  type        = list(string)
  default     = ["POD","Service","Node"]
}
variable "Vnet_subnet_address" {
  description = "The subnet in the Vitual Network IP range"
  type        = list(string)
  default     = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]
}
## Control plane AKS
## ControlPlane AKS
variable "aks_subnet_name" {
  description = "The subnet name in the Virtual Network"
  type = list(string)
  default = [ "CluterVnet","controlplane" ]
}
variable "aks_subnet_address" {
    description = "The subnet in the Vitual Network IP range"
    type = list(string)
    default = [ "172.0.244.0/24","172.0.0.0/28" ]
}
# Aks variable
variable "aks_name" {
    description = "The AKS Cluster's Name"
    type = string
    default = "demoaks"
}