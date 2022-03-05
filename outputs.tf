output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnets_id" {
  description = "VPC Public Subnets"
  value       = [for k, v in aws_subnet.public_subnets : v.id]
}

output "private_subnets_id" {
  description = "VPC Private Subnets"
  value       = [for k, v in aws_subnet.private_subnets : v.id]
}

output "igw_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.igw.id
}

output "nat_gws_id" {
  description = "NAT Gateway ID"
  value       = [for k, v in aws_nat_gateway.nat_gw : v.id]
}

