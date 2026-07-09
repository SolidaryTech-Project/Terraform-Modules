#============================================
# Kubecost (minimo, headless)
#============================================
# Instala o cost-analyzer com o Prometheus bundled em modo minimo e
# isolado (uso interno do cost-model, nao e o Prometheus de
# observabilidade). Sem Grafana, sem Ingress, sem persistencia (evita
# criar volumes EBS). A observabilidade de custo e consumida via scrape
# do endpoint /metrics do cost-model (porta 9003) pelo Datadog Agent.
#
# Kubecost depende estruturalmente de um Prometheus para calcular
# alocacao de custo (queries PromQL) — por isso ele sobe aqui, mas
# enxuto e com retencao curta.
#============================================

locals {
  # Autodiscovery do Datadog Agent para raspar o cost-model.
  # Lista de metricas curada de proposito: raspar ".*" explodiria a
  # cardinalidade e o custo de custom metrics no Datadog.
  kubecost_datadog_annotations = var.kubecost_datadog_scrape ? {
    "ad.datadoghq.com/cost-model.checks" = jsonencode({
      openmetrics = {
        instances = [{
          openmetrics_endpoint = "http://%%host%%:9003/metrics"
          namespace            = "kubecost"
          metrics = [
            "node_total_hourly_cost",
            "node_cpu_hourly_cost",
            "node_ram_hourly_cost",
            "node_gpu_hourly_cost",
            "kubecost_node_is_spot",
            "container_cpu_allocation",
            "container_memory_allocation_bytes",
            "container_gpu_allocation",
            "pod_pvc_allocation",
            "pv_hourly_cost",
            "kubecost_load_balancer_cost",
            "kubecost_cluster_management_cost",
          ]
        }]
      }
    })
  } : {}
}

resource "helm_release" "kubecost" {
  name             = "kubecost"
  repository       = "https://kubecost.github.io/cost-analyzer/"
  chart            = "cost-analyzer"
  version          = var.kubecost_chart_version
  namespace        = var.kubecost_namespace
  create_namespace = true

  values = [yamlencode({
    # Sem Grafana embutido — observabilidade vai pro Datadog
    global = {
      grafana = {
        enabled = false
        proxy   = false
      }
    }

    # cost-analyzer efemero (sem PV, sem EBS)
    persistentVolume = {
      enabled = false
    }

    # Anotacoes p/ o Datadog Agent raspar o cost-model (opcional)
    podAnnotations = local.kubecost_datadog_annotations

    # Prometheus bundled: minimo, isolado, retencao curta, sem PV
    prometheus = {
      server = {
        # Kubecost exige retencao >= 3 dias (resolucao diaria). 3d = minimo.
        retention = "3d"
        persistentVolume = {
          enabled = false
        }
        resources = {
          requests = { cpu = "50m", memory = "256Mi" }
          limits   = { memory = "512Mi" }
        }
      }
      alertmanager = { enabled = false }
      pushgateway  = { enabled = false }
    }

    # Daemonset de network costs desligado (minimo)
    networkCosts = {
      enabled = false
    }

    # Recursos enxutos do proprio Kubecost
    kubecostModel = {
      resources = {
        requests = { cpu = "50m", memory = "256Mi" }
      }
    }
    kubecostFrontend = {
      resources = {
        requests = { cpu = "10m", memory = "64Mi" }
      }
    }
  })]

  wait    = true
  timeout = 600
}
