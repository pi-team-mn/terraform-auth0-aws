resource "aws_secretsmanager_secret" "secret" {
    count = length(var.accounts)

    name                    = "${var.application_name}-${var.accounts[count.index].name}"
    kms_key_id              = aws_kms_key.encrypt[count.index].id
    description             = "Secret that allows access to one of our applications"
    policy                  = data.aws_iam_policy_document.secret[count.index].json
    recovery_window_in_days = var.deletion_window
}

resource "aws_secretsmanager_secret_version" "secret" {
    count     = length(var.accounts)
    secret_id = aws_secretsmanager_secret.secret[count.index].id

    secret_string = jsonencode({
        client_id           = auth0_client.client[count.index].client_id
        client_secret       = auth0_client.client[count.index].client_secret
        audience            = var.audience
        domain              = var.domain
        allowed_grant_types = var.allowed_grant_types
    })
}

data "aws_iam_policy_document" "secret" {
    count = length(var.accounts)

    statement {
        sid       = "AllowAccess"
        effect    = "Allow"
        actions   = ["secretsmanager:GetSecretValue"]
        resources = ["*"]
        principals {
            # Allow the other accounts
            identifiers = var.accounts[count.index].authorized_principals
            type        = "AWS"
        }
        condition {
            # Ensure they can only decrypt the current version
            test     = "ForAnyValue:StringEquals"
            values   = ["AWSCURRENT"]
            variable = "secretsmanager:VersionStage"
        }
    }
}
