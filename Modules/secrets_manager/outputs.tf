output "secret_arns" {
  description = "Map of secret key to ARN"
  value       = { for k, v in aws_secretsmanager_secret.this : k => v.arn }
}

output "secret_names" {
  description = "Map of secret key to full secret name in Secrets Manager"
  value       = { for k, v in aws_secretsmanager_secret.this : k => v.name }
}

output "eso_role_arn" {
  description = "ARN of the IRSA role for the External Secrets Operator"
  value       = aws_iam_role.eso.arn
}
