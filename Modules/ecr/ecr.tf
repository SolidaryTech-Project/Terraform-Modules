#============================================
# ECR Repository
#============================================
module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "2.1.0"

  repository_name = var.repository_name

  repository_force_delete           = true
  repository_image_tag_mutability   = "IMMUTABLE"
  repository_read_write_access_arns = [aws_iam_role.ecr_role.arn]

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 2 development images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["development-"]
          countType     = "imageCountMoreThan"
          countNumber   = 2
        }
        action = { type = "expire" }
      },
      {
        rulePriority = 2
        description  = "Keep last 2 staging images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["staging-"]
          countType     = "imageCountMoreThan"
          countNumber   = 2
        }
        action = { type = "expire" }
      },
      {
        rulePriority = 3
        description  = "Keep last 2 production images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["production-"]
          countType     = "imageCountMoreThan"
          countNumber   = 2
        }
        action = { type = "expire" }
      },
      {
        rulePriority = 4
        description  = "Remove untagged images after 7 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = { type = "expire" }
      }
    ]
  })

  tags = merge(var.tags, {
    Name = "${var.name}-ecr"
  })
}
