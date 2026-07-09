#============================================
# IRSA role for ECR access
#============================================
resource "aws_iam_role" "ecr_role" {
  # var.name ja e unico por servico (projeto-ambiente-servico), entao nao
  # repetimos repository_name aqui — evita estourar o limite de 64 chars
  # do IAM (AWS: "expected length of name to be in the range (1 - 64)").
  name = "${var.name}-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringLike = {
          "${replace(var.oidc_provider_url, "https://", "")}:sub" = "system:serviceaccount:*:*"
          "${replace(var.oidc_provider_url, "https://", "")}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy" "ecr_policy" {
  name = "${var.name}-ecr-policy"
  role = aws_iam_role.ecr_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken"]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
        ]
        Resource = "*"
      }
    ]
  })
}
