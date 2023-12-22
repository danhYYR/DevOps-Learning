# Vnet
## Cluster Vnet
variable "aks_id" {
    description = "The ID for the Vnet assigned cluster"
    type = string
}
## Vnet for AKS
variable "vnet_id" {
  description = "The ID for the Vnet assigned cluster"
  type = string
}
# Service Principal
variable "sp-name" {
    description = "The name of Service Pricipal"
    type = string
}