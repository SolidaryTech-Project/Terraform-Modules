variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC (e.g. '10.0.0.0/16')"
}

variable "name" {
  type        = string
  description = "Base name for all resources"
}

variable "subnets" {
  type = map(object({
    type      = string
    public_ip = bool
    az        = string
  }))
  description = "Map of subnet configurations. 'type' must be 'public' or 'private'"
}

variable "eks_cluster_name" {
  type        = string
  description = "EKS cluster name. When set, adds required kubernetes.io tags to subnets"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
