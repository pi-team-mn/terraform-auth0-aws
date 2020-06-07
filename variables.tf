variable "application_name" {
  type        = string
  description = "Name of the application that can access us"
}

variable "authorized_accounts" {
  type        = list(number)
  description = "A list of AWS Account ID's that can access the secrets"
}

variable "audience" {
  type        = string
  description = "The audience that the client needs to verify against. This is the identifier of the resource_server"
}
