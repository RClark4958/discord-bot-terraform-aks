provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg-cascade" {
  name = "rg-cascade"
}

resource "azurerm_kubernetes_cluster" "aks-cascade" {
  name                = "aks-cascade"
  location            = data.azurerm_resource_group.rg-cascade.location
  resource_group_name = data.azurerm_resource_group.rg-cascade.name
  dns_prefix          = "cascade"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-cascade"
    storage_account_name = "satfstate120973"
    container_name       = "sctfstate"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_key_vault" "kv-cascade" {
  name                        = "kv-cascade120973"
  location                    = data.azurerm_resource_group.rg-cascade.location
  resource_group_name         = data.azurerm_resource_group.rg-cascade.name
  tenant_id                   = "4a1ec6af-75da-49e2-ba11-47353d07cfc8"
  enabled_for_disk_encryption = true

  sku_name = "standard"

  access_policy {
    tenant_id = "4a1ec6af-75da-49e2-ba11-47353d07cfc8"
    object_id = "aaae219b-6339-4d7f-b88b-47b778a6bbc1"

    key_permissions = [
      "Create",
      "Get",
      "Delete",
      "List",
      "Update",
      "Import",
      "Backup",
      "Restore",
      "Recover"
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "Backup",
      "Restore",
      "List"
    ]

    certificate_permissions = [
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
      "ListIssuers",
      "ManageContacts",
      "ManageIssuers",
      "SetIssuers",
      "Update",
      "Backup",
      "Restore",
      "Recover"
    ]
  }
}

module "helm_wordpress" {
  source = "./helm_wordpress"

  wordpressUsername = var.wordpressUsername
  wordpressPassword = var.wordpressPassword
  mariadbPassword   = var.mariadbPassword
}

module "discord_bot" {
  source = "./modules/discord_bot"

  discord_bot_image_name = var.discord_bot_image_name
  discord_bot_image_tag  = var.discord_bot_image_tag
  discord_bot_replicas   = var.discord_bot_replicas
  discord_bot_secrets    = var.discord_bot_secrets
}





