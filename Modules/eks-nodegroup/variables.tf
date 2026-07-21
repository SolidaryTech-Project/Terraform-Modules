variable "name" {
  type        = string
  description = "Base name for all resources"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name to join"
}

variable "private_subnet_ids" {
  type        = map(string)
  description = "Private subnet IDs where node group instances will run"
}

variable "ami_type" {
  type        = string
  description = "AMI type for the node group"
  default     = "AL2023_x86_64_STANDARD"
}

variable "instance_types" {
  type        = list(string)
  description = "EC2 instance types for the node group"
  default     = ["t3.small"]
}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes"
  default     = 2
}

variable "min_size" {
  type        = number
  description = "Minimum number of worker nodes"
  default     = 2
}

variable "max_size" {
  type        = number
  description = "Maximum number of worker nodes"
  default     = 4
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "enable_node_auto_repair" {
  type        = bool
  description = "Habilita o EKS Node Auto Repair: substitui automaticamente nodes que o node monitoring agent reporta como travados (ex.: kubelet/containerd morto por OOM), em vez de ficarem NotReady indefinidamente. Requer o addon eks-node-monitoring-agent no cluster."
  default     = true
}
