# secrets_manager

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.28.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.49.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.eso_secrets_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.eso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_iam_policy_document.eso_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eso_secrets_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eso_service_account_name"></a> [eso\_service\_account\_name](#input\_eso\_service\_account\_name) | ServiceAccount name used by the External Secrets Operator | `string` | `"external-secrets"` | no |
| <a name="input_eso_service_account_namespace"></a> [eso\_service\_account\_namespace](#input\_eso\_service\_account\_namespace) | Namespace where the ESO ServiceAccount lives | `string` | `"external-secrets"` | no |
| <a name="input_name"></a> [name](#input\_name) | Base name for IAM resources | `string` | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | ARN of the EKS OIDC provider (for IRSA) | `string` | n/a | yes |
| <a name="input_oidc_provider_url"></a> [oidc\_provider\_url](#input\_oidc\_provider\_url) | URL of the EKS OIDC provider (e.g. https://oidc.eks.<region>.amazonaws.com/id/XXXX) | `string` | n/a | yes |
| <a name="input_secret_path_prefix"></a> [secret\_path\_prefix](#input\_secret\_path\_prefix) | Path prefix for all secrets (e.g. 'myproject/production'). Secrets are created at <prefix>/<key>. | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Map of secrets to manage. Key = path suffix after secret\_path\_prefix. value = map of key-value pairs stored as JSON (required by ESO dataFrom.extract). null means the secret will be populated externally. | <pre>map(object({<br>    description = string<br>    value       = optional(map(string), null)<br>    service_tag = optional(string, "shared")<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eso_role_arn"></a> [eso\_role\_arn](#output\_eso\_role\_arn) | ARN of the IRSA role for the External Secrets Operator |
| <a name="output_secret_arns"></a> [secret\_arns](#output\_secret\_arns) | Map of secret key to ARN |
| <a name="output_secret_names"></a> [secret\_names](#output\_secret\_names) | Map of secret key to full secret name in Secrets Manager |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
