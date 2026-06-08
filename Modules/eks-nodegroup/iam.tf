#============================================
# IAM Role for the node group (EC2 worker nodes)
#============================================
resource "aws_iam_role" "mng" {
  name = "${var.name}-mng-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })

  tags = merge(var.tags, {
    Name = "${var.name}-mng-role"
  })
}

resource "aws_iam_role_policy_attachment" "mng_worker" {
  role       = aws_iam_role.mng.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "mng_registry" {
  role       = aws_iam_role.mng.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "mng_cni" {
  role       = aws_iam_role.mng.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
