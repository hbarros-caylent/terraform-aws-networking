module "tamr_networking" {
  #source = "git::https://github.com/Datatamer/terraform-aws-networking.git?ref=1.0.1"
  source                        = "../../examples/minimal"
  name_prefix                   = var.name_prefix
  ingress_cidr_blocks           = var.ingress_cidr_blocks
  vpc_cidr_block                = var.vpc_cidr_block
  data_subnet_cidr_blocks       = var.data_subnet_cidr_blocks
  application_subnet_cidr_block = var.application_subnet_cidr_block
  compute_subnet_cidr_block     = var.compute_subnet_cidr_block
  availability_zones            = var.availability_zones
  create_public_subnets         = false
  create_load_balancing_subnets = false
  enable_nat_gateway            = false
  tags                          = var.tags
}
