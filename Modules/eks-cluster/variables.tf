variable "name" {
  type        = string
  description = "Base name for all resources"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
  default     = "1.32"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs where the EKS cluster control plane will be placed"
}

variable "endpoint_private_access" {
  type        = bool
  description = "Whether the EKS private API server endpoint is enabled"
  default     = true
}

variable "endpoint_public_access" {
  type        = bool
  description = "Whether the EKS public API server endpoint is enabled"
  default     = true
}

variable "cluster_api_allowed_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to reach the cluster API on port 443"
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
