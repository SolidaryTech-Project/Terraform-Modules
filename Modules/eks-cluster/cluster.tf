#============================================
# EKS Cluster
#============================================
# trivy:ignore:AVD-AWS-0039
# trivy:ignore:AVD-AWS-0040
# trivy:ignore:AVD-AWS-0041
resource "aws_eks_cluster" "this" {
  name     = "${var.name}-cluster"
  role_arn = aws_iam_role.cluster.arn
  version  = var.kubernetes_version

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [aws_iam_role_policy_attachment.cluster]

  tags = merge(var.tags, {
    Name = "${var.name}-cluster"
  })
}

#============================================
# Node Monitoring Agent
#============================================
# Addon que reporta as condicoes de saude dos nodes (kubelet parado,
# containerd travado, etc.). E o sinal que o node_repair_config do modulo
# eks-nodegroup consome pra saber quando substituir um node - sem ele, o
# Node Auto Repair fica ligado mas sem nada pra agir em cima.
resource "aws_eks_addon" "node_monitoring_agent" {
  count        = var.enable_node_monitoring_agent ? 1 : 0
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "eks-node-monitoring-agent"
}
