variable "wordpressUsername" {
    description = "The wordpress username used to log into admin interface"
    type = string
}

variable "wordpressPassword" {
    description = "The password used to login into the wordpress admin interface"
    type = string
}

variable "mariadbPassword" {
    description = "Password for the database"
    type = string
}