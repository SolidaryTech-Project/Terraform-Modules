variable "name" {
  type        = string
  description = "Base name for all resources"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "delay_seconds" {
  type        = number
  description = "Seconds to delay delivery of all messages"
  default     = 0
}

variable "max_message_size" {
  type        = number
  description = "Maximum message size in bytes"
  default     = 262144
}

variable "message_retention_seconds" {
  type        = number
  description = "Seconds SQS retains a message"
  default     = 86400
}

variable "receive_wait_time_seconds" {
  type        = number
  description = "Long polling wait time in seconds"
  default     = 10
}

variable "visibility_timeout_seconds" {
  type        = number
  description = "Seconds a message is invisible after being received"
  default     = 60
}

variable "max_receive_count" {
  type        = number
  description = "Number of receives before moving message to DLQ"
  default     = 5
}

variable "dlq_message_retention_seconds" {
  type        = number
  description = "Seconds the DLQ retains a message"
  default     = 86400
}

#============================================
# KEDA IRSA (optional)
#============================================
variable "create_keda_irsa" {
  type        = bool
  description = "Cria a role IRSA para o KEDA ler esta fila (scaler aws-sqs-queue)"
  default     = false
}

variable "oidc_provider_arn" {
  type        = string
  description = "ARN do OIDC provider do EKS (para IRSA do KEDA)"
  default     = ""
}

variable "oidc_provider_url" {
  type        = string
  description = "URL do OIDC provider do EKS (para IRSA do KEDA)"
  default     = ""
}

variable "keda_namespace" {
  type        = string
  description = "Namespace onde o keda-operator roda"
  default     = "keda"
}

variable "keda_service_account_name" {
  type        = string
  description = "Nome do ServiceAccount do keda-operator"
  default     = "keda-operator"
}
