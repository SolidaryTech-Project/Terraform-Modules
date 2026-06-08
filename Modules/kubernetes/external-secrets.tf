#============================================
# External Secrets Operator — AWS ↔ Namespace mapping
# Uses kubectl_manifest (no CRD validation on plan) to allow
# single-apply alongside the ESO helm_release.
#============================================

data "aws_region" "current" {}

locals {
  secret_prefix = "${var.project_name}/${var.environment}"
}

resource "kubectl_manifest" "cluster_secret_store" {
  yaml_body = yamlencode({
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ClusterSecretStore"
    metadata = {
      name = "aws-secrets"
    }
    spec = {
      provider = {
        aws = {
          service = "SecretsManager"
          region  = data.aws_region.current.id
          auth = {
            jwt = {
              serviceAccountRef = {
                name      = var.eso_service_account_name
                namespace = var.eso_service_account_namespace
              }
            }
          }
        }
      }
    }
  })
}

resource "kubectl_manifest" "external_secrets" {
  for_each = var.external_secrets

  depends_on = [
    kubernetes_namespace_v1.services,
    kubectl_manifest.cluster_secret_store,
  ]

  yaml_body = yamlencode({
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ExternalSecret"
    metadata = {
      name      = each.value.target_secret
      namespace = each.value.namespace
    }
    spec = {
      refreshInterval = "3m"
      secretStoreRef = {
        kind = "ClusterSecretStore"
        name = "aws-secrets"
      }
      target = {
        name           = each.value.target_secret
        creationPolicy = "Owner"
      }
      dataFrom = [{
        extract = {
          key = "${local.secret_prefix}/${each.value.aws_key}"
        }
      }]
    }
  })
}
