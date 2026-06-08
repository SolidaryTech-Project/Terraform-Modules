variable "name" {
  type        = string
  description = "Base name for IAM resources"
}

variable "secret_path_prefix" {
  type        = string
  description = "Path prefix for all secrets (e.g. 'myproject/production'). Secrets are created at <prefix>/<key>."
}

variable "secrets" {
  type = map(object({
    description = string
    value       = optional(string, null)
    service_tag = optional(string, "shared")
  }))
  description = "Map of secrets to manage. Key = path suffix after secret_path_prefix. value = null means the secret will be populated externally (e.g. by a pipeline)."
  default     = {}
}

variable "oidc_provider_arn" {
  type        = string
  description = "ARN of the EKS OIDC provider (for IRSA)"
}

variable "oidc_provider_url" {
  type        = string
  description = "URL of the EKS OIDC provider (e.g. https://oidc.eks.<region>.amazonaws.com/id/XXXX)"
}

variable "eso_service_account_name" {
  type        = string
  description = "ServiceAccount name used by the External Secrets Operator"
  default     = "external-secrets"
}

variable "eso_service_account_namespace" {
  type        = string
  description = "Namespace where the ESO ServiceAccount lives"
  default     = "external-secrets"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
