# databases

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.28.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.49.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamodb_table"></a> [dynamodb\_table](#module\_dynamodb\_table) | terraform-aws-modules/dynamodb-table/aws | 4.1.0 |
| <a name="module_rds_postgres"></a> [rds\_postgres](#module\_rds\_postgres) | terraform-aws-modules/rds/aws | ~> 6.12 |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.rds_master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.rds_master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_password.rds_master](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Name of the database to create inside the RDS instance | `string` | n/a | yes |
| <a name="input_dynamodb_attributes"></a> [dynamodb\_attributes](#input\_dynamodb\_attributes) | List of DynamoDB attribute definitions (at minimum the hash key attribute) | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | n/a | yes |
| <a name="input_dynamodb_hash_key"></a> [dynamodb\_hash\_key](#input\_dynamodb\_hash\_key) | Attribute name to use as the hash (partition) key | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Base name for all resources | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Private subnet IDs for the database subnet group | `list(string)` | n/a | yes |
| <a name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | Allocated storage in GB | `number` | `20` | no |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | PostgreSQL engine version | `string` | `"15.7"` | no |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | RDS instance class | `string` | `"db.t3.micro"` | no |
| <a name="input_rds_parameter_group_family"></a> [rds\_parameter\_group\_family](#input\_rds\_parameter\_group\_family) | DB parameter group family (e.g. postgres15) | `string` | `"postgres15"` | no |
| <a name="input_rds_username"></a> [rds\_username](#input\_rds\_username) | Master username for the RDS instance | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR block used to allow inbound traffic | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where databases will be placed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | DynamoDB table name |
| <a name="output_rds_db_name"></a> [rds\_db\_name](#output\_rds\_db\_name) | RDS database name |
| <a name="output_rds_instance_address"></a> [rds\_instance\_address](#output\_rds\_instance\_address) | RDS instance hostname (without port) |
| <a name="output_rds_instance_endpoint"></a> [rds\_instance\_endpoint](#output\_rds\_instance\_endpoint) | RDS instance endpoint |
| <a name="output_rds_instance_id"></a> [rds\_instance\_id](#output\_rds\_instance\_id) | RDS instance ID |
| <a name="output_rds_instance_port"></a> [rds\_instance\_port](#output\_rds\_instance\_port) | RDS instance port |
| <a name="output_rds_master_secret_arn"></a> [rds\_master\_secret\_arn](#output\_rds\_master\_secret\_arn) | ARN of the Secrets Manager secret containing RDS master credentials |
| <a name="output_rds_password"></a> [rds\_password](#output\_rds\_password) | RDS master password (URL-safe, generated via random\_password) |
| <a name="output_rds_security_group_id"></a> [rds\_security\_group\_id](#output\_rds\_security\_group\_id) | RDS security group ID |
| <a name="output_rds_username"></a> [rds\_username](#output\_rds\_username) | RDS master username |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
