variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}


variable "virtual_network_name" {
  type = string
}
variable virtual_network_address_space {
    type = list(string)
    default = ["10.0.0.0/16"]
}


variable "subnet_address_prefixes" {
   type = list(string)
   default = ["10.0.1.0/24"]
}



variable "my_vm_mapping" {
  type = map(object({
    name = string
    my_vm_size            = string
    admin_username        = string
    admin_password        = string
    publisher             = string
    os                    = string
    sku                   = string
    skuversion            = string
   
  }))
  default = {}
}
