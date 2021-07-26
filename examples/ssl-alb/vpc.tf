module "tamr_networking" {
  source                = "../../"
  vpc_cidr_block        = "10.0.0.0/16"
  ingress_cidr_blocks   = var.ingress_cidr_blocks
  availability_zones    = var.availability_zones
  create_public_subnets = true
  enable_nat_gateway    = true
  create_loadbalancing_subnets = true
  tags                  = var.tags
}
