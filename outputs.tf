output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID of the network."
}

output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "The CIDR block of the VPC."
}

output "compute_subnet_id" {
  value       = local.compute_subnet
  description = "ID of the subnet where mainly the EMR cluster will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well."
}

output "application_subnet_id" {
  value       = local.application_subnet
  description = "ID of the subnet where mainly the Tamr VM and the Cloudwatch VPC Endpoint will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well."
}

output "application_subnet_cidr_block" {
  value       = var.application_subnet_cidr_block
  description = "The CIDR block of the Application Subnet."
}

output "data_subnet_ids" {
  value       = local.data_subnets
  description = "ID of the subnet where mainly the RDS will be created. If `abac_valid_tags` key values are set, this subnet is required to have a valid key value tag as well."
}

output "tamr_ec2_availability_zone" {
  value       = module.vpc.azs
  description = "The list of availability zones where we should deploy resources."
}

output "public_subnet_ids" {
  value       = local.public_subnets
  description = "ID of the public subnets created in the VPC."
}

output "load_balancing_subnet_ids" {
  value       = local.load_balancing_subnets
  description = "ID of the Application Load Balancer subnet."
}

output "vpce_logs_endpoint_dnsname" {
  value       = module.endpoints.endpoints["logs"].dns_entry[0]["dns_name"]
  description = "Cloudwatch VPC Interface Endpoint DNS name which will be provided to the script to install and configure the Cloudwatch agent."
}
