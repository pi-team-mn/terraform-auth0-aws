variable "application_name" {
    type        = string
    description = "Name of the application that can access us"
}

variable "accounts" {
    type = list(object({
        name                  = string
        authorized_principals = list(string)
        scope                 = list(string)
    }))
}

variable "domain" {
    type        = string
    description = "Auth0 domain used for authentication"
}

variable "audience" {
    type        = string
    description = "The audience that the client needs to verify against. This is the identifier of the resource_server"
}

variable "allowed_grant_types" {
    type        = list(string)
    description = "The grants that the auth0 client will give"
    default     = [
        "client_credentials"
    ]
}

variable "region" {
    type        = string
    default     = "eu-central-1"
    description = "Region to create secrets in"
}

variable "application_type" {
    type        = string
    default     = "non_interactive"
    description = "Application type for the client."
}

variable "tags" {
    default     = {}
    type        = map (string)
    description = "Tags for the AWS resources"
}

variable "deletion_window" {
    default     = 7
    description = "Deletion window in which the secret can be recovered"
}

locals {
    root_account = "arn:aws:iam::${data.aws_caller_identity.identity.account_id}:root"
}
