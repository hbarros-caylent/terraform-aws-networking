module "tamr_networking" {
    source = "../../"
    ingress_cidr_blocks = var.ingress_cidr_blocks
    availability_zones = var.availability_zones
    create_public_subnets = true
    enable_nat_gateway = true
}
