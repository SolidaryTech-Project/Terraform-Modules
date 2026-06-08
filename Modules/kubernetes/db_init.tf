#============================================
# Database Init Jobs
# Creates databases and runs initial migrations for each service.
# Idempotent: uses CREATE DATABASE/TABLE IF NOT EXISTS.
# Each service must have a SQL file at sql/<service-without-suffix>.sql
#============================================

resource "kubectl_manifest" "db_init_configmap" {
  for_each = var.db_init_services

  depends_on = [kubernetes_namespace_v1.services]

  yaml_body = yamlencode({
    apiVersion = "v1"
    kind       = "ConfigMap"
    metadata = {
      name      = "${each.key}-db-init-sql"
      namespace = each.key
    }
    data = {
      "init.sql" = file("${path.module}/sql/${replace(each.key, "-service", "")}.sql")
    }
  })
}

resource "kubectl_manifest" "db_init_job" {
  for_each = var.db_init_services

  depends_on = [
    kubernetes_namespace_v1.services,
    kubectl_manifest.external_secrets,
    kubectl_manifest.db_init_configmap,
  ]

  yaml_body = yamlencode({
    apiVersion = "batch/v1"
    kind       = "Job"
    metadata = {
      name      = "${each.key}-db-init"
      namespace = each.key
    }
    spec = {
      backoffLimit            = 6
      ttlSecondsAfterFinished = 300
      template = {
        spec = {
          restartPolicy = "OnFailure"
          containers = [{
            name  = "psql"
            image = "postgres:15"
            env = [{
              name  = "POSTGRES_DB"
              value = replace(each.key, "-service", "_db")
            }]
            envFrom = [{
              secretRef = {
                name = "${each.key}-db-credentials"
              }
            }]
            command = ["sh", "-c"]
            args = [
              <<-EOT
              set -e
              export PGPASSWORD="$POSTGRES_PASSWORD"
              psql -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d postgres \
                -tAc "SELECT 1 FROM pg_database WHERE datname = '$POSTGRES_DB'" | grep -q 1 \
                || psql -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d postgres \
                     -c "CREATE DATABASE $POSTGRES_DB"
              psql -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB" \
                   -v ON_ERROR_STOP=1 -f /sql/init.sql
              EOT
            ]
            volumeMounts = [{
              name      = "init-sql"
              mountPath = "/sql"
            }]
          }]
          volumes = [{
            name = "init-sql"
            configMap = {
              name = "${each.key}-db-init-sql"
            }
          }]
        }
      }
    }
  })
}
