terraform {
  backend "azurerm" {
    resource_group_name  = "rg-secplat-bootstrap"
    storage_account_name = "stsecplatqyvv8y"
    container_name       = "tfstate"
    key                  = "bootstrap.terraform.tfstate"
  }
}

