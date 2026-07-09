#============================================
# IRSA role para o KEDA (scaler aws-sqs-queue)
#============================================
# Criada apenas quando var.create_keda_irsa = true, para nao forcar
# IRSA em toda fila. Amarra ao SA do keda-operator via OIDC e concede
# leitura dos atributos DESTA fila (profundidade da fila).
#
# O KEDA operator usa esta role via podIdentity: aws-eks no
# TriggerAuthentication (definido no chart do servico).
#============================================
locals {
  oidc_host = replace(var.oidc_provider_url, "https://", "")
}

data "aws_iam_policy_document" "keda_assume_role" {
  count = var.create_keda_irsa ? 1 : 0

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
      values   = ["system:serviceaccount:${var.keda_namespace}:${var.keda_service_account_name}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_host}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "keda_sqs_read" {
  count = var.create_keda_irsa ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
    ]
    resources = [module.sqs.queue_arn]
  }
}

resource "aws_iam_policy" "keda_sqs_read" {
  count       = var.create_keda_irsa ? 1 : 0
  name        = "${var.name}-keda-sqs-read"
  description = "Allows KEDA operator to read attributes of the ${var.name} SQS queue"
  policy      = data.aws_iam_policy_document.keda_sqs_read[0].json
  tags        = var.tags
}

resource "aws_iam_role" "keda" {
  count              = var.create_keda_irsa ? 1 : 0
  name               = "${var.name}-keda-irsa"
  assume_role_policy = data.aws_iam_policy_document.keda_assume_role[0].json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "keda" {
  count      = var.create_keda_irsa ? 1 : 0
  role       = aws_iam_role.keda[0].name
  policy_arn = aws_iam_policy.keda_sqs_read[0].arn
}
