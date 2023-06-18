variable "wordpressUsername" {}
variable "wordpressPassword" {}
variable "mariadbPassword" {}

variable "discord_bot_image_name" {
  description = "Name of the Docker image for the discord bot"
  type        = string
}

variable "discord_bot_image_tag" {
  description = "Tag of the Docker image for the discord bot"
  type        = string
}

variable "discord_bot_replicas" {
  description = "Number of replicas for the discord bot deployment"
  type        = number
}

variable "discord_bot_secrets" {
  description = "Secrets for the discord bot"
  type        = map(string)
}

variable "rg_main_name" {
  description = "The azure resource group"
  type        = string
}

variable "aks_main_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for aks cluster"
  type        = string
}

variable "tfstate_storage_account_name" {
  description = "Name of the account used to store the tfstate"
  type        = string
}

variable "tfstate_container_name" {
  description = "The container holding the tfstate"
  type = string
}

variable "tfstate_key" {
  description = "Key for the tfstate file"
  type = string
}

variable "kv_main_name" {
  description = "Name of the primary key vault"
  type = string
}

variable "tenant_id" {
  description = "The tenant id"
  type= string
}

variable "kv_main_object_key" {
  description = "The key vault's object key for use with service principal"
  type = string
}