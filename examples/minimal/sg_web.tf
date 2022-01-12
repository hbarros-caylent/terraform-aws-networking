module "sg_vm_web" {
  source = "git::git@github.com:Datatamer/terraform-aws-security-groups.git?ref=1.0.0"
  vpc_id = module.tamr_networking.vpc_id
  egress_cidr_blocks = [
    "0.0.0.0/0"
  ]
  egress_protocol         = "all"
  ingress_security_groups = []
  ingress_protocol        = ""
  ingress_ports           = []
  sg_name_prefix          = format("%s-%s", "example-minimal", "application-sg")
  tags                    = var.tags
}
