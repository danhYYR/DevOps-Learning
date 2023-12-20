variable "rg_name" {
  description = "The name of the resource group which created by terraform"
  type = string
}
variable "rg_location" {
    description = "The location which will be hosted the AKS cluster"
    type = string
}
variable "aks_name" {
    description = "The AKS Cluster's Name"
    type = string
}
variable "aks_id" {
  description = "The AKS ID"
  type = string
}
variable "linuxpool_vm" {
  type = map(string)
  default = {
    "name" = "linuxpool"
    "vmsize" = "Standard_B2s"
    "tags" = "system-app"
    "os_disk_size_gb" = 30
    "os_type" = "Linux" 
    "count" = 2
  }
}