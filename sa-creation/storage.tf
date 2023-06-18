provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg-cascade" {
  name     = "rg-cascade"
}

resource "azurerm_storage_account" "sa-tfstate" {
  name                     = "satfstate120973"
  resource_group_name      = data.azurerm_resource_group.rg-cascade.name
  location                 = data.azurerm_resource_group.rg-cascade.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "sc-tfstate" {
  name                  = "sctfstate"
  storage_account_name  = azurerm_storage_account.sa-tfstate.name
  container_access_type = "private"
}
