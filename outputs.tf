output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}


output "compute_subnet_id" {
  value = local.compute_subnet
}

output "application_subnet_id" {
  value = local.application_subnet
}

output "application_subnet_cidr_block" {
  value = var.application_subnet_cidr_block
}

output "data_subnet_group_ids" {
  value = local.data_subnets
}

output "tamr_ec2_availability_zone" {
  value = module.vpc.azs[0]
}

output "public_subnet_ids" {
  value = local.public_subnets
}
