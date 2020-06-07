provider "aws" {}

provider "auth0" {}

module "test" {
  source              = "../"
  application_name    = "auth0-terraform-module-test"
  audience            = auth0_resource_server.server.identifier
  authorized_accounts = [0]
}

resource "auth0_resource_server" "server" {
  name        = "auth0-terraform-module-resource-server"
  identifier  = "auth0-terraform-module-resource-server"
  signing_alg = "RS256"

}


