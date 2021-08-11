module "tamr_networking" {
  #source = "git::https://github.com/Datatamer/terraform-aws-networking.git?ref=0.1.0"
  source                        = "../../"
  ingress_cidr_blocks           = ["172.16.0.0/16"]
  vpc_cidr_block                = "10.0.0.0/16"
  data_subnet_cidr_blocks       = ["10.0.2.0/24", "10.0.3.0/24"]
  application_subnet_cidr_block = "10.0.0.0/24"
  compute_subnet_cidr_block     = "10.0.1.0/24"
  availability_zones            = var.availability_zones
  create_public_subnets         = false
  create_load_balancing_subnets = false
  enable_nat_gateway            = false
  tags = {
    "Name" : "tamr-vpc-minimal"
    "application" : "tamr",
    "Terraform" : "true"
  }
}
