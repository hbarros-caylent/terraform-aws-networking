data "aws_instance" "tamr-vm" {
  instance_id = var.ec2_instance_id
}

module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  version            = "~> 6.0"
  name               = "tamr-ssl-example"
  load_balancer_type = "application"
  vpc_id             = var.vpc_id
  subnets            = var.subnet_ids
  security_groups    = [module.sg_https_lb.security_group_id]
  internal           = true
  tags               = var.tags
  target_groups = [
    {
      name_prefix      = "tamr-"
      backend_protocol = "HTTP"
      backend_port     = 9100
      target_type      = "instance"
      targets = [
        {
          target_id = var.ec2_instance_id
          port      = 9100
        }
      ]
    }
  ]
  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.tls_certificate_arn
      target_group_index = 0
    }
  ]
}

module "sg_https_lb" {
  source = "terraform-aws-modules/security-group/aws//modules/https-443"

  name                = "web"
  use_name_prefix     = true
  description         = "Security group for tamr-vm with HTTPS ports open within VPC"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  ingress_rules       = var.tls_certificate_arn == "" ? ["http-80-tcp"] : ["https-443-tcp"]
  egress_with_source_security_group_id = [
    {
      from_port                = 9100
      to_port                  = 9100
      protocol                 = "tcp"
      description              = "Web from the load balancer"
      source_security_group_id = tolist(data.aws_instance.tamr-vm.vpc_security_group_ids)[0]
    }
  ]
  tags = var.tags
}
