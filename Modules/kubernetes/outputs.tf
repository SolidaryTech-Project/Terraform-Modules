#============================================
# Kubernetes Namespace Outputs
#============================================

output "namespaces" {
  description = "Map de todas as namespaces criadas"
  value       = { for k, v in kubernetes_namespace_v1.services : k => v.metadata[0].name }
}
