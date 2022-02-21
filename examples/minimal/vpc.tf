module "tamr_networking" {
  #source = "git::https://github.com/Datatamer/terraform-aws-networking.git?ref=0.1.0"
  source                             = "../../"
  ingress_cidr_blocks                = var.ingress_cidr_blocks
  vpc_cidr_block                     = var.vpc_cidr_block
  data_subnet_cidr_blocks            = var.data_subnet_cidr_blocks
  application_subnet_cidr_block      = var.application_subnet_cidr_block
  compute_subnet_cidr_block          = var.compute_subnet_cidr_block
  load_balancing_subnets_cidr_blocks = var.load_balancing_subnets_cidr_blocks
  public_subnets_cidr_blocks         = var.public_subnets_cidr_blocks
  availability_zones                 = var.availability_zones
  create_public_subnets              = var.create_public_subnets
  create_load_balancing_subnets      = var.create_load_balancing_subnets
  enable_nat_gateway                 = var.enable_nat_gateway
  name_prefix                        = var.name_prefix
  interface_endpoint_ingress_sg      = module.sg_vm_web.security_group_ids[0]
  tags                               = var.tags
}
