output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_ids" {
  description = "Map of public subnet key to NAT Gateway ID"
  value       = { for k, v in aws_nat_gateway.this : k => v.id }
}

output "subnet_ids" {
  description = "Map of subnet key to subnet ID"
  value       = { for k, v in aws_subnet.this : k => v.id }
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for k, v in aws_subnet.this : v.id if var.subnets[k].type == "public"]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for k, v in aws_subnet.this : v.id if var.subnets[k].type == "private"]
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Map of subnet key to private route table ID"
  value       = { for k, v in aws_route_table.private : k => v.id }
}
