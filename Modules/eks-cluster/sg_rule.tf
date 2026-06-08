#============================================
# Ingress rule for external cluster API access (e.g. kubectl from local machine)
#============================================
resource "aws_security_group_rule" "cluster_api_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.cluster_api_allowed_cidrs
  security_group_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  description       = "Allow kubectl access to EKS API server"
}
