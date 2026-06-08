resource "aws_secretsmanager_secret" "this" {
  for_each = var.secrets

  name                    = "${var.secret_path_prefix}/${each.key}"
  description             = each.value.description
  recovery_window_in_days = 0

  tags = merge(var.tags, {
    Service = each.value.service_tag
  })
}

# Only creates a version for secrets that have a value defined.
# Secrets with value = null are created empty and filled externally (e.g. by CI/CD pipeline).
resource "aws_secretsmanager_secret_version" "this" {
  for_each = { for k, v in var.secrets : k => v if v.value != null }

  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = each.value.value
}
