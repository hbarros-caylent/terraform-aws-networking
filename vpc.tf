locals {
  private_subnets_cidrs = concat(
    flatten([
      [var.application_subnet_cidr_block],
      [var.compute_subnet_cidr_block],
      [var.data_subnet_cidr_blocks]
    ])
  )
  public_subnets_cidrs = var.public_subnets_cidr_blocks
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"
  name = "tamr-vpc"
  cidr = var.vpc_cidr_block

  azs                    = var.availability_zones
  private_subnets        = local.private_subnets_cidrs
  public_subnets         = var.create_public_subnets ? local.public_subnets_cidrs : []
  enable_nat_gateway     = var.enable_nat_gateway && var.create_public_subnets ? true : false
  single_nat_gateway     = var.enable_nat_gateway ? true : false
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = false
  // if disabled, EMR throws Error waiting for EMR Cluster state to be "WAITING" or "RUNNING"
  // See https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-troubleshoot-error-vpc.html
  enable_dns_support            = true
  enable_dns_hostnames          = true
  public_dedicated_network_acl  = false
  private_dedicated_network_acl = false
  manage_default_network_acl    = false
  manage_default_route_table    = var.enable_nat_gateway

  tags = var.tags
}
