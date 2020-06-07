resource "aws_kms_key" "encrypt" {
  description = "Encryption key for ${var.application_name}"
}
