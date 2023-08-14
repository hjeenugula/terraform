terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  client_id = "fa59decf-dc47-4630-92d1-37895979f1bf"
  tenant_id = "83a39466-6231-47d0-9c3e-7e5d0d6c2f36"
  subscription_id = "0a190bcc-981d-4572-b433-d9332bf7a0bf"
  client_secret = "Wa_8Q~ubqZ2HK~wPlXd0pVzRer.EINpofppVAbOC"
}
terraform {
  backend "azurerm" {
    resource_group_name = "mystorageresourcegroup"
    storage_account_name = "myterraformstatefile"
    container_name       = "mystatefile"
    key                  = "harikastatefile.tfstate"
    
  }
}
