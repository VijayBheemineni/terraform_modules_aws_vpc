output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets_id" {
  value = module.vpc.public_subnets_id
}

output "private_subnets_id" {
  value = module.vpc.private_subnets_id
}

output "igw_id" {
  value = module.vpc.igw_id
}

output "nat_gws_id" {
  value = module.vpc.nat_gws_id
}
