#============================================
# RDS Security Group
#============================================
resource "aws_security_group" "rds" {
  name        = "${var.name}-rds-sg"
  description = "Allow Postgres traffic from inside VPC"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow PostgreSQL from within the VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow outbound traffic within the VPC"
  }

  tags = merge(var.tags, {
    Name = "${var.name}-rds-sg"
  })
}

#============================================
# Master password — URL-safe chars only
# Avoids percent-encoding issues in postgres:// connection strings
#============================================
resource "random_password" "rds_master" {
  length           = 32
  special          = true
  override_special = "_-.~"
  upper            = true
  lower            = true
  numeric          = true
}

# trivy:ignore:AVD-AWS-0098
resource "aws_secretsmanager_secret" "rds_master" {
  name                    = "${var.name}/rds/master"
  description             = "RDS master user credentials (URL-safe chars)"
  recovery_window_in_days = 0

  tags = merge(var.tags, {
    Name = "${var.name}-rds-master-secret"
  })
}

resource "aws_secretsmanager_secret_version" "rds_master" {
  secret_id = aws_secretsmanager_secret.rds_master.id
  secret_string = jsonencode({
    username = var.rds_username
    password = random_password.rds_master.result
  })
}

#============================================
# RDS Instance
#============================================
module "rds_postgres" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.12"

  identifier = "${var.name}-rds"

  engine            = "postgres"
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  allocated_storage = var.rds_allocated_storage

  db_name                     = var.db_name
  username                    = var.rds_username
  password                    = random_password.rds_master.result
  manage_master_user_password = false
  port                        = 5432

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [aws_security_group.rds.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  performance_insights_enabled = true

  monitoring_interval    = "30"
  monitoring_role_name   = "${var.name}-rds-monitoring-role"
  create_monitoring_role = true

  create_db_subnet_group = true
  subnet_ids             = var.private_subnet_ids

  family = var.rds_parameter_group_family

  deletion_protection = false
  skip_final_snapshot = true

  tags = merge(var.tags, {
    Name = "${var.name}-rds"
  })
}
