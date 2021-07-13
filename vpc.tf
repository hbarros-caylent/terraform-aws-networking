locals {
  cidrs           = cidrsubnets(var.vpc_cidr_block, 8, 8, 8, 8, 8, 8)
  private_subnets = slice(local.cidrs, 0, 4)
  public_subnets  = slice(local.cidrs, 4, 6)
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "tamr-vpc"
  cidr = var.vpc_cidr_block

  azs                    = var.availability_zones
  private_subnets        = local.private_subnets
  public_subnets         = var.create_public_subnets ? local.public_subnets : []
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

  tags = {
    Terraform   = "true"
    Environment = "Terraform Managed"
  }
}
