module "sg_https_lb" {
  source = "terraform-aws-modules/security-group/aws//modules/https-443"

  name            = "web"
  use_name_prefix = true
  description = "Security group for tamr-vm with HTTPS ports open within VPC"
  vpc_id      = module.tamr_networking.vpc_id
  ingress_cidr_blocks      = var.ingress_cidr_blocks
  ingress_rules            = var.tls_certificate_arn == "" ? ["http-80-tcp"] : ["https-443-tcp"]
  egress_with_source_security_group_id = [
    {
      from_port                = 9100
      to_port                  = 9100
      protocol                 = "tcp"
      description              = "Web from the loadbalancer"
      source_security_group_id = module.tamr-vm.tamr_security_groups[0]
    }
  ]
  tags = var.tags
}
