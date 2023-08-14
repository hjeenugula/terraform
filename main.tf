resource "azurerm_resource_group" "harika_rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "harika_vn" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address_space
  location            = azurerm_resource_group.harika_rg.location
  resource_group_name = azurerm_resource_group.harika_rg.name
}

resource "azurerm_public_ip" "harika_publicip" {
  for_each           = var.my_vm_mapping
  name                = "publicip-${each.value.name}"
  location            = azurerm_resource_group.harika_rg.location
  resource_group_name = azurerm_resource_group.harika_rg.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "production"
  }
}

resource "azurerm_subnet" "harika_subnet" {
  for_each              = var.my_vm_mapping
  name                 = "subnetname-${each.value.name}"
  resource_group_name  = azurerm_resource_group.harika_rg.name
  virtual_network_name = azurerm_virtual_network.harika_vn.name
  address_prefixes     = var.subnet_address_prefixes
}


resource "azurerm_network_interface" "harika_ni" {
  for_each            = var.my_vm_mapping
  name                = "nic-${each.value.name}"
  location            = azurerm_resource_group.harika_rg.location
  resource_group_name = azurerm_resource_group.harika_rg.name

  ip_configuration {
    name                          = "config-${each.key}"
    subnet_id                     = azurerm_subnet.harika_subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.harika_publicip[each.key].id

  }
  
}

resource "azurerm_virtual_machine" "harika_vm" {
  for_each              = var.my_vm_mapping
  name                  = each.value.name
  location              = azurerm_resource_group.harika_rg.location
  resource_group_name   = azurerm_resource_group.harika_rg.name
  network_interface_ids = [azurerm_network_interface.harika_ni[each.key].id]
  vm_size               = each.value.my_vm_size


  storage_image_reference {
    publisher = each.value.publisher
    offer     = each.value.os
    sku       = each.value.sku
    version   = each.value.skuversion
  }
  storage_os_disk {
    name              = "myosdisk-${each.value.name}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = each.value.name
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  
}

