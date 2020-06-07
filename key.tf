resource "aws_kms_key" "encrypt" {
  description = "Encryption key for ${var.application_name}"
  policy      = data.aws_iam_policy_document.encrypt.json
}

resource "aws_kms_alias" "encrypt" {
  target_key_id = aws_kms_key.encrypt.id
  name          = "alias/${var.application_name}"
}

data "aws_iam_policy_document" "encrypt" {
  statement {
    sid       = "AllowKeyUsageByRemote"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["kms:Decrypt", "kms:DescribeKey"]
    principals {
      identifiers = var.authorized_accounts
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
