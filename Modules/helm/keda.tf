#============================================
# KEDA (Kubernetes Event-driven Autoscaling)
#============================================
# Instala o operator do KEDA, que estende o autoscaling nativo do
# Kubernetes com ScaledObjects/ScaledJobs. Os scalers de CPU/memoria
# usam o metrics-server (ja instalado neste modulo) e nao dependem de
# Prometheus. O KEDA sobe em seu proprio namespace.
#
# Os ScaledObjects por servico (ngo/donation/volunteer) ficam nos
# charts de cada aplicacao — este modulo entrega apenas o operator.
#============================================

resource "helm_release" "keda" {
  name       = "keda"
  repository = "https://kedacore.github.io/charts"
  chart      = "keda"
  version    = var.keda_chart_version
  namespace  = var.keda_namespace

  create_namespace = true

  # Anota o SA do keda-operator com a role IRSA quando fornecida.
  # Necessario para o scaler aws-sqs-queue autenticar via podIdentity: aws-eks.
  dynamic "set" {
    for_each = var.keda_role_arn != "" ? [1] : []
    content {
      name  = "serviceAccount.operator.annotations.eks\\.amazonaws\\.com/role-arn"
      value = var.keda_role_arn
    }
  }

  wait    = true
  timeout = 300
}
