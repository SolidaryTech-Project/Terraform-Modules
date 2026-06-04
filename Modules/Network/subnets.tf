#============================================
# Subnets
#============================================
resource "aws_subnet" "this" {
  for_each = local.subnets_indexed

  vpc_id                  = aws_vpc.this.id
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.public_ip

  cidr_block = cidrsubnet(var.cidr_block, 8, each.value.index)

  tags = merge(
    var.tags,
    { Name = "${var.name}-${each.key}-subnet" },
    var.eks_cluster_name != null ? { "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared" } : {},
    var.eks_cluster_name != null && each.value.type == "public" ? { "kubernetes.io/role/elb" = "1" } : {},
    var.eks_cluster_name != null && each.value.type == "private" ? { "kubernetes.io/role/internal-elb" = "1" } : {}
  )
}
