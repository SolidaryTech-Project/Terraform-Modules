#============================================
# Managed Node Group
#============================================
resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.name}-node-group"
  node_role_arn   = aws_iam_role.mng.arn
  ami_type        = var.ami_type
  instance_types  = var.instance_types
  subnet_ids      = values(var.private_subnet_ids)

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  tags = merge(var.tags, {
    Name = "${var.name}-node-group"
  })

  depends_on = [
    aws_iam_role_policy_attachment.mng_worker,
    aws_iam_role_policy_attachment.mng_cni,
    aws_iam_role_policy_attachment.mng_registry,
  ]
}
