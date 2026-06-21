resource "aws_secretsmanager_secret" "this" {
  for_each = var.secrets

  name                    = "${var.secret_path_prefix}/${each.key}"
  description             = each.value.description
  recovery_window_in_days = 0

  tags = merge(var.tags, {
    Service = try(join(", ", each.value.service_tag), tostring(each.value.service_tag))
  })
}

# Secrets with value = null are created empty and filled externally (e.g. by CI/CD pipeline).
# for_each must only depend on var.secrets' keys (known at plan time), not on
# each.value.value, since some values are unknown until apply (e.g. resource attributes).
resource "aws_secretsmanager_secret_version" "this" {
  for_each = var.secrets

  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = each.value.value != null ? each.value.value : " "

  lifecycle {
    ignore_changes = [secret_string]
  }
}
