# Resoure group
variable "rg_name" {
  description = "The name of the Resource Group"
  type = string
}
variable "rg_location" {
  description = "The Resource Group location"
  type = string
}
# Virtual network

variable "Vnet_prefix" {
    description = "Set up the Vnet Prefix range"
    type = list(string)
}
variable "Vnet_subnet_name" {
  description = "The subnet name in the Virtual Network"
  type = list(string)
}
variable "Vnet_subnet_address" {
    description = "The subnet in the Vitual Network IP range"
    type = list(string)
}