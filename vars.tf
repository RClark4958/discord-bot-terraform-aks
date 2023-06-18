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
