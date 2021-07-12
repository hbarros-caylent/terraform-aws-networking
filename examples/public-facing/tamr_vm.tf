/*module "tamr_ec2_key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  version    = "1.0.0"
  key_name   = format("%s-tamr-ec2-test-key", var.name-prefix)
  public_key = tls_private_key.tamr_ec2_private_key.public_key_openssh
}

module "aws-vm-sg-ports" {
  source = "git::https://github.com/Datatamer/terraform-aws-tamr-vm.git//modules/aws-security-groups?ref=2.0.0"
  #source = "../../modules/aws-security-groups"
}*/

module "aws-sg" {
  source = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id = module.tamr_networking.vpc_id
  egress_cidr_blocks = [
    "0.0.0.0/0"
  ]
  egress_protocol = "all"
  ingress_security_groups = [module.https_lb.security_group_id]
  ingress_protocol = "all"
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
  subnet_id         = module.tamr_networking.tamr_ec2_subnet_id
  bootstrap_scripts = [
    # NOTE: If you would like to use local scripts, you can use terraform's file() function
    # file("./test-bootstrap-scripts/install-pip.sh"),
    # file("./test-bootstrap-scripts/check-install.sh"),
    file("./install-nginx.sh")
    //data.aws_s3_bucket_object.bootstrap_script.body,
    //data.aws_s3_bucket_object.bootstrap_script_2.body
  ]
  depends_on = [
    module.tamr_networking
  ]

  security_group_ids = module.aws-sg.security_group_ids
}