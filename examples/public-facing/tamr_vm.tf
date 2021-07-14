module "sg_vm_web" {
  source = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id = module.tamr_networking.vpc_id
  egress_cidr_blocks = [
    "0.0.0.0/0"
  ]
  egress_protocol = "all"
  ingress_security_groups = [module.https_lb.security_group_id]
  ingress_protocol = "tcp"
  ingress_ports  = ["9100"]
  sg_name_prefix = var.name-prefix
}

module "tamr-vm" {
  source                      = "git::git@github.com:Datatamer/terraform-aws-tamr-vm.git?ref=3.0.0"
  aws_role_name               = format("%s-tamr-ec2-role", var.name-prefix)
  aws_instance_profile_name   = format("%s-tamr-ec2-instance-profile", var.name-prefix)
  aws_emr_creator_policy_name = format("%sEmrCreatorPolicy", var.name-prefix)
  s3_policy_arns = [
  #  module.s3-bucket.rw_policy_arn,
  ]
  ami               = var.ami_id
  instance_type     = "r5.2xlarge"
  key_name          = var.key_pair
  availability_zone = var.availability_zones[0]
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
