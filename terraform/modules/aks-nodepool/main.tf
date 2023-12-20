resource "azurerm_kubernetes_cluster_node_pool" "linuxpool" {
  name = "${var.aks_name}-${lookup(var.linuxpool_vm,"name","linux")}"
  kubernetes_cluster_id = var.aks_id
  vm_size = lookup(var.linuxpool_vm,"vmsize","Standard_B1s")
  node_count = lookup(var.linuxpool_vm,"count","1")
}