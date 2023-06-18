# Should be run first to create the rg and the storage resources necessary for terraform.

resource "azurerm_resource_group" "rg-main" {
  name = var.rg_main_name
  location = "West US 2"
}

provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "sa-tfstate" {
  name                     = var.tfstate_storage_account_name
  resource_group_name      = azurerm_resource_group.rg-main.name
  location                 = azurerm_resource_group.rg-main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "sc-tfstate" {
  name                  = var.tfstate_container_name
  storage_account_name  = azurerm_storage_account.sa-tfstate.name
  container_access_type = "private"
}

