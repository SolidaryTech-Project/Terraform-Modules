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

  depends_on = [aws_iam_role_policy_attachment.cluster]

  tags = merge(var.tags, {
    Name = "${var.name}-cluster"
  })
}
