output "vpc_id" {
  value = module.tamr_vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.tamr_vpc.vpc_cidr_block
}


output "compute_subnet_id" {
  value = module.tamr_vpc.compute_subnet_id
}

output "application_subnet_id" {
  value = module.tamr_vpc.application_subnet_id
}

output "application_subnet_cidr_block" {
  value = module.tamr_vpc.application_subnet_cidr_block
}

output "data_subnet_group_ids" {
  value = module.tamr_vpc.data_subnet_group_ids
}

output "tamr_ec2_availability_zone" {
  value = module.tamr_vpc.tamr_ec2_availability_zone
}

output "public_subnet_ids" {
  value = module.tamr_vpc.public_subnet_ids
}
