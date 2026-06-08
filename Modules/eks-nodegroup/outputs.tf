output "node_group_name" {
  description = "Name of the EKS node group"
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_arn" {
  description = "ARN of the EKS node group"
  value       = aws_eks_node_group.this.arn
}

output "node_role_arn" {
  description = "ARN of the IAM role attached to the node group"
  value       = aws_iam_role.mng.arn
}
