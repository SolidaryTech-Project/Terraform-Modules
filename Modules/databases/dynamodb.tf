#============================================
# DynamoDB Table
#============================================
module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "4.1.0"

  name     = "${var.name}-dynamodb"
  hash_key = var.dynamodb_hash_key

  attributes = var.dynamodb_attributes

  point_in_time_recovery_enabled = true
  server_side_encryption_enabled = true

  tags = merge(var.tags, {
    Name = "${var.name}-dynamodb"
  })
}
