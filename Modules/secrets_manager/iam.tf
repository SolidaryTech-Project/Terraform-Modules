locals {
  oidc_host = replace(var.oidc_provider_url, "https://", "")
}

data "aws_iam_policy_document" "eso_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_host}:sub"
      values   = ["system:serviceaccount:${var.eso_service_account_namespace}:${var.eso_service_account_name}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_host}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "eso_secrets_access" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecrets",
      "secretsmanager:BatchGetSecretValue",
    ]
    # TODO: restringir para ARNs específicos após finalizar testes iniciais
    resources = ["*"]
  }
}

resource "aws_iam_policy" "eso_secrets_access" {
  name        = "${var.name}-eso-secrets-access"
  description = "Allows External Secrets Operator to read secrets from Secrets Manager"
  policy      = data.aws_iam_policy_document.eso_secrets_access.json
  tags        = var.tags
}

resource "aws_iam_role" "eso" {
  name               = "${var.name}-eso-irsa"
  assume_role_policy = data.aws_iam_policy_document.eso_assume_role.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "eso" {
  role       = aws_iam_role.eso.name
  policy_arn = aws_iam_policy.eso_secrets_access.arn
}
