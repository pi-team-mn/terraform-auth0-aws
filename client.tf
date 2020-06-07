resource "auth0_client" "client" {
    count       = length(var.accounts)
    # The client that our customers will use
    name        = "${var.application_name}-${var.accounts[count.index].name}"
    app_type    = var.application_type
    grant_types = var.allowed_grant_types
}

resource "auth0_client_grant" "client" {
    count     = length(var.accounts)
    # Access to our audience for this client
    audience  = var.audience
    client_id = auth0_client.client[count.index].id
    scope     = var.accounts[count.index].scope
}
