variable "region" {
    default = "eu-central-1"
}

provider "aws" {
    region = var.region
}

provider "auth0" {}

resource "auth0_resource_server" "server" {
    name        = "auth0-terraform-module-resource-server"
    identifier  = "auth0-terraform-module-resource-server"
    signing_alg = "RS256"

}

module "test" {
    source           = "../"
    application_name = "auth0-terraform-module-test"
    audience         = auth0_resource_server.server.identifier
    region           = var.region
    domain           = "tetete"
    deletion_window  = 0

    accounts = [
        {
            name                  = "MDTPI",
            authorized_principals = [765948204630]
            scope                 = []
        }]
}

