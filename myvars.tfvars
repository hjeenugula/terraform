resource_group_name = "harikarg"
location = "East US"
virtual_network_name = "harikavn"
virtual_network_address_space = ["10.0.0.0/16"]
subnet_address_prefixes = ["10.0.1.0/24"]



my_vm_mapping = {
  "harikavm1" = {
    name = "harikavm1"
    my_vm_size            = "Standard_DS1_v2"
    admin_username        = "harika"
    admin_password        = "Reddy06"
    publisher             = "Canonical"
    os                    = "UbuntuServer"
    sku                   = "18.04-LTS"
    skuversion            = "latest"
    
  },
  "harikavm2" = {
    name = "harikavm2"
    my_vm_size            = "Standard_B1s"
    admin_username        = "harika1"
    admin_password        = "Reddy06"
    publisher             = "Canonical"
    os                    = "UbuntuServer"
    sku                   = "18.04-LTS"
    skuversion            = "latest"
    
  }
}
