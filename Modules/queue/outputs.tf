#============================================
# SQS Outputs
#============================================
output "sqs_queue_url" {
  description = "SQS queue URL"
  value       = module.sqs.queue_url
}

output "sqs_queue_id" {
  description = "SQS queue ID"
  value       = module.sqs.queue_id
}

output "sqs_queue_arn" {
  description = "SQS queue ARN"
  value       = module.sqs.queue_arn
}

output "keda_role_arn" {
  description = "ARN da role IRSA do KEDA (null quando create_keda_irsa = false)"
  value       = var.create_keda_irsa ? aws_iam_role.keda[0].arn : null
}
