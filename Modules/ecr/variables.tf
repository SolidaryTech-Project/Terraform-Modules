variable "name" {
  type        = string
  description = "Base name for all resources"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "repository_name" {
  type        = string
  description = "ECR repository name"
}

variable "oidc_provider_arn" {
  type        = string
  description = "ARN of the IAM OIDC provider associated with the EKS cluster"
}

variable "oidc_provider_url" {
  type        = string
  description = "URL of the IAM OIDC provider associated with the EKS cluster"
}
