resource "azurerm_network_interface" "jump_host_nic" {
  name                = "jump-host-nic"
  resource_group_name = var.rg_name
  location            = var.rg_location
  
  ip_configuration {
    name                          = "jump-host-ip-config"
    subnet_id                     = var.vnet_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id
  }
}
resource "azurerm_linux_virtual_machine" "jp_vm" {
    name = "jumhostvm"
    resource_group_name = var.rg_name
    location = var.rg_location
    size = lookup(var.VM_conf,"size","Standard_B1s")
    admin_username = var.admin_username
    admin_ssh_key {
      username = var.admin_username
      public_key = var.ssh_public_key
    }
    network_interface_ids = [azurerm_network_interface.jump_host_nic.id]
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "Ubuntu Server"
        sku       = "22_04-lts"
        version   = "latest"
    }

}