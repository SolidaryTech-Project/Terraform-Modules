variable "project_name" {
  type        = string
  description = "Project name for resource naming"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g. development, production)"
}

variable "namespaces_k8s" {
  type        = set(string)
  description = "Kubernetes namespaces managed by Terraform"
  default     = []
}

variable "external_secrets" {
  type = map(object({
    namespace     = string
    aws_key       = string
    target_secret = string
  }))
  description = "Map of ExternalSecret configurations. Key = logical name, value = ExternalSecret spec."
  default     = {}
}

variable "db_init_services" {
  type        = set(string)
  description = "Set of service names to run database init jobs for. Each service must have a corresponding SQL file at sql/<service-without-suffix>.sql"
  default     = []
}

variable "eso_service_account_name" {
  type        = string
  description = "ServiceAccount name of the External Secrets Operator"
  default     = "external-secrets"
}

variable "eso_service_account_namespace" {
  type        = string
  description = "Namespace of the External Secrets Operator ServiceAccount"
  default     = "external-secrets"
}
