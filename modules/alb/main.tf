
data "aws_instances" "masters" {

  filter {
    name   = "tag:aws:elasticmapreduce:job-flow-id"
    values = [var.emr_cluster_id]
  }

  filter {
    name   = "tag:aws:elasticmapreduce:instance-group-role"
    values = ["MASTER"]
  }

}

data "aws_instance" "tamr_ec2" {
  instance_id = var.ec2_instance_id
}


locals {
  target_group_emr = length(data.aws_instances.masters.ids)
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
    /*
    {
      name_prefix      = "tamr-"
      backend_protocol = "HTTP"
      backend_port     = var.tamr_unify_port
      target_type      = "instance"
      targets = [
        {
          target_id = var.ec2_instance_id
          port      = var.tamr_unify_port
        }
      ]
    },
    {
      name_prefix      = "tamr-"
      backend_protocol = "HTTP"
      backend_port     = var.tamr_dms_port
      target_type      = "instance"
      targets = [
        {
          target_id = var.ec2_instance_id
          port      = var.tamr_dms_port
        }
      ]
    },
    {
      name_prefix      = "tamr-"
      backend_protocol = "HTTP"
      backend_port     = "80"
      target_type      = "instance"
      targets = [
        {
          target_id = data.aws_instances.masters.ids[0]
          port      = "80"
        }
      ]
    },
    {
      name_prefix      = "tamr-"
      backend_protocol = "HTTP"
      backend_port     = "16010"
      target_type      = "instance"
      targets = [
        {
          target_id = data.aws_instances.masters.ids[0]
          port      = "16010"
        }
      ]
    },*/
    {
      name      = "tamr-default"
      backend_protocol = "HTTP"
      backend_port     = var.tamr_unify_port
      target_type      = "instance"
      targets = [
        {
          target_id = var.ec2_instance_id
          port      = "9100"
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

resource "aws_lb_target_group" "target_groups" {
  for_each = var.host_routing_map
  name     = each.key
  port     = each.value.port
  health_check {
    // We accept anything that indicates that the host is running. For future implementations
    // we might add a field to the object to allow this to be configured.
    enabled = true
    protocol = "HTTP"
    matcher = "200-499"
  }
  protocol = "HTTP"
  vpc_id   = var.vpc_id
} 

resource "aws_lb_target_group_attachment" "tg_attachments" {
  for_each = aws_lb_target_group.target_groups
  target_group_arn = each.value.arn
  target_id        = lookup(var.host_routing_map, each.key).instance_id
  port             = lookup(var.host_routing_map, each.key).port
}

resource "aws_lb_listener_rule" "listeners" {
  for_each = aws_lb_target_group.target_groups
  listener_arn = module.alb.https_listener_arns[0]
  action {
    type             = "forward"
    target_group_arn = each.value.arn
  }
  condition {
    host_header {
      values = lookup(var.host_routing_map, each.key).hosts
    }
  }
}

/*
resource "aws_lb_target_group" "ganglia" {
  name     = "ganglia"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "tamr" {
  #for_each = data.aws_instances.masters.ids
  target_group_arn = aws_lb_target_group.tamr.arn
  target_id        = var.ec2_instance_id
  port             = 9100
}

resource "aws_lb_target_group_attachment" "emr_masters_ganglia" {
  count = var.master_fleet_instance_count
  target_group_arn = aws_lb_target_group.ganglia.arn
  target_id        = data.aws_instances.masters.ids[count.index]
  port             = 80
}


resource "aws_lb_listener_rule" "dms" {
  count        = var.enable_host_routing ? 1 : 0
  listener_arn = module.alb.https_listener_arns[0]
  priority     = 101
  action {
    type             = "forward"
    target_group_arn = module.alb.target_group_arns[1]
  }
  condition {
    host_header {
      values = lookup(var.host_routing_map, "dms", [""])
    }
  }
}

resource "aws_lb_listener_rule" "ganglia" {
  count        = var.enable_host_routing ? 1 : 0
  listener_arn = module.alb.https_listener_arns[0]
  priority     = 102
  action {
    type             = "forward"
    target_group_arn = module.alb.target_group_arns[2]
  }
  condition {
    host_header {
      values = lookup(var.host_routing_map, "ganglia", [""])
    }
  }
}

resource "aws_lb_listener_rule" "hbase" {
  count        = var.enable_host_routing ? 1 : 0
  listener_arn = module.alb.https_listener_arns[0]
  priority     = 103
  action {
    type             = "forward"
    target_group_arn = module.alb.target_group_arns[3]
  }
  condition {
    host_header {
      values = lookup(var.host_routing_map, "hbase", [""])
    }
  }
}

resource "aws_lb_listener_rule" "spark" {
  count        = var.enable_host_routing ? 1 : 0
  listener_arn = module.alb.https_listener_arns[0]
  priority     = 104
  action {
    type             = "forward"
    target_group_arn = module.alb.target_group_arns[4]
  }
  condition {
    host_header {
      values = lookup(var.host_routing_map, "spark", [""])
    }
  }
}
*/

module "sg_https_lb" {
  source              = "terraform-aws-modules/security-group/aws//modules/https-443"
  name                = "web"
  use_name_prefix     = true
  description         = "Security group for tamr-vm with HTTPS ports open within VPC"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = var.ingress_cidr_blocks
  ingress_rules       = var.tls_certificate_arn == "" ? ["http-80-tcp"] : ["https-443-tcp"]
  egress_with_source_security_group_id = [
    {
      from_port                = var.tamr_unify_port
      to_port                  = var.tamr_unify_port
      protocol                 = "tcp"
      description              = "Web from the load balancer"
      source_security_group_id = tolist(data.aws_instance.tamr-vm.vpc_security_group_ids)[0]
    }
  ]
  tags = var.tags
}

data "aws_instance" "tamr-vm" {
  instance_id = var.ec2_instance_id
}
