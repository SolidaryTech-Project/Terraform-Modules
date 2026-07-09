variable "aws_region" {
  type        = string
  description = "AWS region (used for NLB cleanup on destroy)"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name (used for kubeconfig refresh on destroy)"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the NLB lives (used to verify cleanup on destroy)"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to AWS resources provisioned outside Terraform (e.g. the NLB behind the ingress-nginx Service)"
  default     = {}
}

#============================================
# External Secrets Operator
#============================================
variable "eso_role_arn" {
  type        = string
  description = "ARN of the IRSA role for the ESO ServiceAccount"
}

variable "eso_namespace" {
  type        = string
  description = "Namespace where ESO will be installed"
  default     = "external-secrets"
}

variable "eso_service_account_name" {
  type        = string
  description = "ESO ServiceAccount name (must match the IRSA trust policy)"
  default     = "external-secrets"
}

variable "eso_chart_version" {
  type        = string
  description = "external-secrets Helm chart version"
  default     = "0.10.7"
}

#============================================
# NGINX Ingress Controller
#============================================
variable "nginx_namespace" {
  type        = string
  description = "Namespace where NGINX Ingress Controller will be installed"
  default     = "ingress-nginx"
}

variable "nginx_chart_version" {
  type        = string
  description = "ingress-nginx Helm chart version"
  default     = "4.11.3"
}

#============================================
# Metrics Server
#============================================
variable "metrics_server_namespace" {
  type        = string
  description = "Namespace where Metrics Server will be installed"
  default     = "kube-system"
}

variable "metrics_server_chart_version" {
  type        = string
  description = "metrics-server Helm chart version"
  default     = "3.12.2"
}

#============================================
# KEDA
#============================================
variable "keda_namespace" {
  type        = string
  description = "Namespace where KEDA will be installed"
  default     = "keda"
}

variable "keda_chart_version" {
  type        = string
  description = "KEDA Helm chart version"
  default     = "2.20.1"
}

variable "keda_role_arn" {
  type        = string
  description = "ARN da role IRSA para o SA do keda-operator (vazio = sem IRSA/SQS scaler)"
  default     = ""
}

#============================================
# Kubecost
#============================================
variable "kubecost_namespace" {
  type        = string
  description = "Namespace onde o Kubecost sera instalado"
  default     = "kubecost"
}

variable "kubecost_chart_version" {
  type        = string
  description = "cost-analyzer Helm chart version"
  default     = "2.9.6"
}

variable "kubecost_datadog_scrape" {
  type        = bool
  description = "Injeta anotacoes de autodiscovery do Datadog Agent para raspar o /metrics do cost-model"
  default     = false
}
