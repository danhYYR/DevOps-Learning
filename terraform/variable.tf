# General name
## Check your enviroment incase the terraform required input value
variable "environment" {
  description = "Set up the enviroment type"
  type = string
}
variable "grp_name" {
  description = "The resource group will be use deploy the SA"
  type = string
}
variable "sa_name" {
  description = "The Storage to store the tfstate"
  type = string  
}
variable "sa_container_name" {
  description = "The name of container assign the tfstate"
  type = string
}
variable "sa_key" {
  description = "The key of sa which store the tfstate"
  type = string
}
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

