output "secret_arn" {
  value = aws_secretsmanager_secret.secret.*.arn
}

output "key_arn" {
  value = aws_kms_key.encrypt.*.arn
}
