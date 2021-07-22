locals {
  ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.tamr-vm.id
  az     = length(var.availability_zones) > 0 ? var.availability_zones[0] : data.aws_availability_zones.available.names[0]
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "tamr-vm" {
  most_recent = true
  owners      = ["679593333241"]
  name_regex  = "^Ubuntu 18.04 Tamr.*"
  filter {
    name   = "product-code"
    values = ["832nkbrayw00cnivlh6nbbi6p"]
  }
}

module "sg_vm_web" {
  source = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id = module.tamr_networking.vpc_id
  egress_cidr_blocks = [
    "0.0.0.0/0"
  ]
  egress_protocol         = "all"
  ingress_security_groups = [module.sg_https_lb.security_group_id]
  ingress_protocol        = "tcp"
  ingress_ports           = ["9100"]
  sg_name_prefix          = var.name-prefix
}

module "tamr-vm" {
  source                      = "git::git@github.com:Datatamer/terraform-aws-tamr-vm.git?ref=3.1.0"
  aws_role_name               = format("%s-tamr-ec2-role", var.name-prefix)
  aws_instance_profile_name   = format("%s-tamr-ec2-instance-profile", var.name-prefix)
  aws_emr_creator_policy_name = format("%sEmrCreatorPolicy", var.name-prefix)
  ami               = local.ami_id
  instance_type     = "r5.2xlarge"
  key_name          = var.key_pair
  availability_zone = local.az
  vpc_id            = module.tamr_networking.vpc_id
  subnet_id         = module.tamr_networking.application_subnet_id
  bootstrap_scripts = [
    file("./install-nginx.sh")
  ]
  depends_on = [
    module.tamr_networking
  ]

  security_group_ids = module.sg_vm_web.security_group_ids
  // DEPRECATED. USE TAGS INSTEAD
  tamr_instance_tags = var.tags
}
