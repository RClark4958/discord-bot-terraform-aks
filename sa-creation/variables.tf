variable "tfstate_storage_account_name" {
  description = "Name of the account used to store the tfstate"
  type        = string
}

variable "tfstate_container_name" {
  description = "The container holding the tfstate"
  type = string
}

variable "rg_main_name" {
  description = "The azure resource group"
  type        = string
}
