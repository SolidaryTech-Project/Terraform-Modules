# kubernetes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.28.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.14 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 3.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.49.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.19.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 3.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.cluster_secret_store](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.db_init_configmap](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.db_init_job](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.external_secrets](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace_v1.services](https://registry.terraform.io/providers/hashicorp/kubernetes/3.0.1/docs/resources/namespace_v1) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region (used for kubeconfig refresh on destroy) | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name (used for kubeconfig refresh on destroy) | `string` | n/a | yes |
| <a name="input_db_init_services"></a> [db\_init\_services](#input\_db\_init\_services) | Set of service names to run database init jobs for. Each service must have a corresponding SQL file at sql/<service-without-suffix>.sql | `set(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (e.g. development, production) | `string` | n/a | yes |
| <a name="input_eso_service_account_name"></a> [eso\_service\_account\_name](#input\_eso\_service\_account\_name) | ServiceAccount name of the External Secrets Operator | `string` | `"external-secrets"` | no |
| <a name="input_eso_service_account_namespace"></a> [eso\_service\_account\_namespace](#input\_eso\_service\_account\_namespace) | Namespace of the External Secrets Operator ServiceAccount | `string` | `"external-secrets"` | no |
| <a name="input_external_secrets"></a> [external\_secrets](#input\_external\_secrets) | Map of ExternalSecret configurations. Key = logical name, value = ExternalSecret spec. | <pre>map(object({<br>    namespace     = string<br>    aws_key       = string<br>    target_secret = string<br>  }))</pre> | `{}` | no |
| <a name="input_namespaces_k8s"></a> [namespaces\_k8s](#input\_namespaces\_k8s) | Kubernetes namespaces managed by Terraform | `set(string)` | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name for resource naming | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespaces"></a> [namespaces](#output\_namespaces) | Map de todas as namespaces criadas |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
