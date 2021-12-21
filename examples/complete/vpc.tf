module "tamr_networking" {

  source                             = "../../"
  vpc_cidr_block                     = "10.0.0.0/16"
  application_subnet_cidr_block      = "10.0.0.0/24"
  compute_subnet_cidr_block          = "10.0.1.0/24"
  data_subnet_cidr_blocks            = ["10.0.2.0/24", "10.0.3.0/24"]
  load_balancing_subnets_cidr_blocks = ["10.0.4.0/24", "10.0.5.0/24"]
  public_subnets_cidr_blocks         = ["10.0.6.0/24", "10.0.7.0/24"]
  ingress_cidr_blocks                = var.ingress_cidr_blocks
  availability_zones                 = var.availability_zones
  create_public_subnets              = true
  enable_nat_gateway                 = false
  create_load_balancing_subnets      = true
  name_prefix                        = var.name_prefix
  interface_endpoint_ingress_sg      = module.sg_vm_web.security_group_ids[0]
  tags                               = var.tags
}
