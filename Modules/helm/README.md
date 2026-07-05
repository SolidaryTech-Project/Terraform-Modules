# helm

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.28.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.17 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.external_secrets](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.keda](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.nginx_ingress](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [null_resource.nginx_lb_drain](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region (used for NLB cleanup on destroy) | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name (used for kubeconfig refresh on destroy) | `string` | n/a | yes |
| <a name="input_eso_chart_version"></a> [eso\_chart\_version](#input\_eso\_chart\_version) | external-secrets Helm chart version | `string` | `"0.10.7"` | no |
| <a name="input_eso_namespace"></a> [eso\_namespace](#input\_eso\_namespace) | Namespace where ESO will be installed | `string` | `"external-secrets"` | no |
| <a name="input_eso_role_arn"></a> [eso\_role\_arn](#input\_eso\_role\_arn) | ARN of the IRSA role for the ESO ServiceAccount | `string` | n/a | yes |
| <a name="input_eso_service_account_name"></a> [eso\_service\_account\_name](#input\_eso\_service\_account\_name) | ESO ServiceAccount name (must match the IRSA trust policy) | `string` | `"external-secrets"` | no |
| <a name="input_keda_chart_version"></a> [keda\_chart\_version](#input\_keda\_chart\_version) | KEDA Helm chart version | `string` | `"2.20.1"` | no |
| <a name="input_keda_namespace"></a> [keda\_namespace](#input\_keda\_namespace) | Namespace where KEDA will be installed | `string` | `"keda"` | no |
| <a name="input_metrics_server_chart_version"></a> [metrics\_server\_chart\_version](#input\_metrics\_server\_chart\_version) | metrics-server Helm chart version | `string` | `"3.12.2"` | no |
| <a name="input_metrics_server_namespace"></a> [metrics\_server\_namespace](#input\_metrics\_server\_namespace) | Namespace where Metrics Server will be installed | `string` | `"kube-system"` | no |
| <a name="input_nginx_chart_version"></a> [nginx\_chart\_version](#input\_nginx\_chart\_version) | ingress-nginx Helm chart version | `string` | `"4.11.3"` | no |
| <a name="input_nginx_namespace"></a> [nginx\_namespace](#input\_nginx\_namespace) | Namespace where NGINX Ingress Controller will be installed | `string` | `"ingress-nginx"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to AWS resources provisioned outside Terraform (e.g. the NLB behind the ingress-nginx Service) | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where the NLB lives (used to verify cleanup on destroy) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eso_namespace"></a> [eso\_namespace](#output\_eso\_namespace) | Namespace onde o External Secrets Operator foi instalado |
| <a name="output_eso_release_name"></a> [eso\_release\_name](#output\_eso\_release\_name) | Nome do release Helm do ESO |
| <a name="output_eso_service_account_name"></a> [eso\_service\_account\_name](#output\_eso\_service\_account\_name) | Nome do ServiceAccount do ESO (para referenciar em ClusterSecretStore) |
| <a name="output_keda_namespace"></a> [keda\_namespace](#output\_keda\_namespace) | Namespace onde o KEDA está instalado |
| <a name="output_keda_release_name"></a> [keda\_release\_name](#output\_keda\_release\_name) | Nome do release Helm do KEDA |
| <a name="output_metrics_server_release_name"></a> [metrics\_server\_release\_name](#output\_metrics\_server\_release\_name) | Nome do release Helm do Metrics Server |
| <a name="output_nginx_ingress_namespace"></a> [nginx\_ingress\_namespace](#output\_nginx\_ingress\_namespace) | Namespace onde o NGINX Ingress Controller está instalado |
| <a name="output_nginx_ingress_release_name"></a> [nginx\_ingress\_release\_name](#output\_nginx\_ingress\_release\_name) | Nome do release Helm do NGINX Ingress Controller |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
