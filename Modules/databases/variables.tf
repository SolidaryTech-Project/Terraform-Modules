variable "name" {
  type        = string
  description = "Base name for all resources"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

#============================================
# VPC
#============================================
variable "vpc_id" {
  type        = string
  description = "VPC ID where databases will be placed"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block used to allow inbound traffic"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for the database subnet group"
}

#============================================
# RDS
#============================================
variable "rds_username" {
  type        = string
  description = "Master username for the RDS instance"
}

variable "db_name" {
  type        = string
  description = "Name of the database to create inside the RDS instance"
}

variable "rds_engine_version" {
  type        = string
  description = "PostgreSQL engine version"
  default     = "15.7"
}

variable "rds_instance_class" {
  type        = string
  description = "RDS instance class"
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  type        = number
  description = "Allocated storage in GB"
  default     = 20
}

variable "rds_parameter_group_family" {
  type        = string
  description = "DB parameter group family (e.g. postgres15)"
  default     = "postgres15"
}

#============================================
# DynamoDB
#============================================
variable "dynamodb_hash_key" {
  type        = string
  description = "Attribute name to use as the hash (partition) key"
}

variable "dynamodb_attributes" {
  type = list(object({
    name = string
    type = string
  }))
  description = "List of DynamoDB attribute definitions (at minimum the hash key attribute)"
}
