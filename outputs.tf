output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}


output "compute_subnet_id" {
  value = module.vpc.private_subnets[2]
}

output "application_subnet_id" {
  value = module.vpc.private_subnets[0]
}

output "application_subnet_cidr_block" {
  value = module.vpc.private_subnets_cidr_blocks[0]
}

output "data_subnet_group_ids" {
  value = ["${module.vpc.private_subnets[2]}", "${module.vpc.private_subnets[3]}"]
}

output "tamr_ec2_availability_zone" {
  value = module.vpc.azs[0]
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}
