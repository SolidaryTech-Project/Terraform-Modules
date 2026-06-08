#============================================
# Kubernetes Namespaces
# Note: argocd namespace is intentionally excluded — it is created by the
# deployment pipeline. Managing it here causes "Terminating" hangs on destroy.
#============================================
resource "kubernetes_namespace_v1" "services" {
  for_each = var.namespaces_k8s

  metadata {
    name = each.value
    labels = {
      "admission.datadoghq.com/enabled" = "true"
    }
  }
}
