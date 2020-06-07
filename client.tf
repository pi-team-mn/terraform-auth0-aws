resource "auth0_client" "client" {
  # The client that our customers will use
  name        = var.application_name
  app_type    = var.application_type
  grant_types = var.allowed_grant_types
}

resource "auth0_client_grant" "client" {
  # Access to our audience for this client
  audience  = var.audience
  client_id = auth0_client.client.id
  scope     = var.scope
}
