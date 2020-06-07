resource "aws_kms_key" "encrypt" {
    count       = length(var.accounts)
    description = "Encryption key for ${var.application_name} ${var.accounts[count.index].name}"
    policy      = data.aws_iam_policy_document.encrypt[count.index].json
}

resource "aws_kms_alias" "encrypt" {
    count         = length(var.accounts)
    target_key_id = aws_kms_key.encrypt[count.index].id
    name          = "alias/${var.application_name}-${var.accounts[count.index].name}"
}

data "aws_iam_policy_document" "encrypt" {
    count = length(var.accounts)
    statement {
        sid       = "AllowKeyUsageByRemote"
        effect    = "Allow"
        resources = ["*"]
        actions   = ["kms:Decrypt", "kms:DescribeKey"]
        principals {
            identifiers = var.accounts[count.index].authorized_principals
            type        = "AWS"
        }
    }
    statement {
        # todo do not allow the creator of the secret access
        sid       = "AllowKeyManagement"
        effect    = "Allow"
        resources = ["*"]
        actions   = [
            "kms:*"
        ]
        principals {
            identifiers = [local.root_account]
            type        = "AWS"
        }
    }
}
