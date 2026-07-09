# queue

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sqs"></a> [sqs](#module\_sqs) | terraform-aws-modules/sqs/aws | 5.2.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.keda_sqs_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.keda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.keda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.keda_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.keda_sqs_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_keda_irsa"></a> [create\_keda\_irsa](#input\_create\_keda\_irsa) | Cria a role IRSA para o KEDA ler esta fila (scaler aws-sqs-queue) | `bool` | `false` | no |
| <a name="input_delay_seconds"></a> [delay\_seconds](#input\_delay\_seconds) | Seconds to delay delivery of all messages | `number` | `0` | no |
| <a name="input_dlq_message_retention_seconds"></a> [dlq\_message\_retention\_seconds](#input\_dlq\_message\_retention\_seconds) | Seconds the DLQ retains a message | `number` | `86400` | no |
| <a name="input_keda_namespace"></a> [keda\_namespace](#input\_keda\_namespace) | Namespace onde o keda-operator roda | `string` | `"keda"` | no |
| <a name="input_keda_service_account_name"></a> [keda\_service\_account\_name](#input\_keda\_service\_account\_name) | Nome do ServiceAccount do keda-operator | `string` | `"keda-operator"` | no |
| <a name="input_max_message_size"></a> [max\_message\_size](#input\_max\_message\_size) | Maximum message size in bytes | `number` | `262144` | no |
| <a name="input_max_receive_count"></a> [max\_receive\_count](#input\_max\_receive\_count) | Number of receives before moving message to DLQ | `number` | `5` | no |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | Seconds SQS retains a message | `number` | `86400` | no |
| <a name="input_name"></a> [name](#input\_name) | Base name for all resources | `string` | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | ARN do OIDC provider do EKS (para IRSA do KEDA) | `string` | `""` | no |
| <a name="input_oidc_provider_url"></a> [oidc\_provider\_url](#input\_oidc\_provider\_url) | URL do OIDC provider do EKS (para IRSA do KEDA) | `string` | `""` | no |
| <a name="input_receive_wait_time_seconds"></a> [receive\_wait\_time\_seconds](#input\_receive\_wait\_time\_seconds) | Long polling wait time in seconds | `number` | `10` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_visibility_timeout_seconds"></a> [visibility\_timeout\_seconds](#input\_visibility\_timeout\_seconds) | Seconds a message is invisible after being received | `number` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_keda_role_arn"></a> [keda\_role\_arn](#output\_keda\_role\_arn) | ARN da role IRSA do KEDA (null quando create\_keda\_irsa = false) |
| <a name="output_sqs_queue_arn"></a> [sqs\_queue\_arn](#output\_sqs\_queue\_arn) | SQS queue ARN |
| <a name="output_sqs_queue_id"></a> [sqs\_queue\_id](#output\_sqs\_queue\_id) | SQS queue ID |
| <a name="output_sqs_queue_url"></a> [sqs\_queue\_url](#output\_sqs\_queue\_url) | SQS queue URL |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
