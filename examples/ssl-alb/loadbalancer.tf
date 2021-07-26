module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  version            = "~> 6.0"
  name               = "tamr-ssl-example"
  load_balancer_type = "application"
  vpc_id             = module.tamr_networking.vpc_id
  subnets            = module.tamr_networking.loadbalancing_subnet_ids
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
          target_id = module.tamr-vm.tamr_instance.ec2_instance_id
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
