resource "aws_secretsmanager_secret" "secret" {
  name        = var.application_name
  kms_key_id  = aws_kms_key.encrypt.id
  description = "Secret that allows access to one of our applications"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id = aws_secretsmanager_secret.secret.id

  secret_string = jsonencode({
    client_id           = auth0_client.client.client_id
    client_secret       = auth0_client.client.client_secret
    audience            = var.audience
    domain              = var.domain
    allowed_grant_types = var.allowed_grant_types
  })
}
