locals {
  // Does not include compute subnet
  private_subnets_cidrs = flatten([
    [var.application_subnet_cidr_block],
    [var.data_subnet_cidr_blocks],
    [local.load_balancing_subnets_cidr_blocks]
  ])
  application_subnet                 = module.vpc.private_subnets[0]
  application_subnet_cidr_block      = module.vpc.private_subnets_cidr_blocks[0]
  data_subnets                       = [module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  data_subnets_cidr_blocks           = [module.vpc.private_subnets_cidr_blocks[1], module.vpc.private_subnets_cidr_blocks[2]]
  compute_subnet                     = aws_subnet.compute_subnet.id
  compute_subnet_cidr_block          = aws_subnet.compute_subnet.cidr_block
  public_subnets                     = module.vpc.public_subnets
  public_subnets_cidr_blocks         = module.vpc.public_subnets_cidr_blocks
  load_balancing_subnets             = var.create_load_balancing_subnets ? [module.vpc.private_subnets[3], module.vpc.private_subnets[4]] : []
  load_balancing_subnets_cidr_blocks = var.create_load_balancing_subnets ? var.load_balancing_subnets_cidr_blocks : []
  public_subnets_cidrs               = var.public_subnets_cidr_blocks
  azs                                = var.availability_zones
}

module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "3.2.0"
  name                   = "tamr-vpc"
  cidr                   = var.vpc_cidr_block
  azs                    = local.azs
  private_subnets        = local.private_subnets_cidrs
  public_subnets         = var.create_public_subnets ? local.public_subnets_cidrs : []
  enable_nat_gateway     = var.enable_nat_gateway && var.create_public_subnets
  single_nat_gateway     = var.enable_nat_gateway
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
  tags                          = var.tags
}

data "aws_subnet" "application_subnet" {
  id = local.application_subnet
}

resource "aws_subnet" "compute_subnet" {
  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.compute_subnet_cidr_block
  availability_zone = data.aws_subnet.application_subnet.availability_zone
  tags              = var.tags
}

resource "aws_route_table" "compute_subnet_rt" {
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

resource "aws_route_table_association" "compute_subnet_rta" {
  subnet_id      = aws_subnet.compute_subnet.id
  route_table_id = aws_route_table.compute_subnet_rt.id
}
