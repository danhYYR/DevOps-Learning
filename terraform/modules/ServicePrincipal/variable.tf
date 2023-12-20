# Vnet
## Cluster Vnet
variable "Cluster_id" {
    description = "The ID for the Vnet assigned cluster"
    type = string
}
## ControlPlane AKS
variable "CP_id" {
  description = "The ID for the Vnet assigned cluster"
  type = string
}
# Service Principal
variable "sp-name" {
    description = "The name of Service Pricipal"
    type = string
}