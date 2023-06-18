provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg-main" {
  name = ""
}

resource "azurerm_kubernetes_cluster" "aks-main" {
  name                = var.aks_main_name
  location            = data.azurerm_resource_group.rg-main.location
  resource_group_name = data.azurerm_resource_group.rg-main.name
  dns_prefix          = var.dns_prefix

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
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    key                  = ""
  }
}

resource "azurerm_key_vault" "kv-main" {
  name                        = var.kv_main_name
  location                    = data.azurerm_resource_group.rg-main.location
  resource_group_name         = data.azurerm_resource_group.rg-main.name
  tenant_id                   = var.tenant_id
  enabled_for_disk_encryption = true

  sku_name = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.kv_main_object_key

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
  source = "./modules/helm_wordpress"

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





