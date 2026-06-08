#============================================
# SQS Standard Queue with DLQ
#============================================
module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "5.2.1"

  name = "${var.name}-queue"

  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds

  sqs_managed_sse_enabled = true

  create_dlq = true
  dlq_name   = "${var.name}-queue-dlq"

  redrive_policy = { maxReceiveCount = var.max_receive_count }

  dlq_message_retention_seconds = var.dlq_message_retention_seconds

  tags = merge(var.tags, {
    Name = "${var.name}-queue"
  })
}
