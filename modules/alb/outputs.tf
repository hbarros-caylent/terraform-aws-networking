output "load_balancer" {
  value = module.alb
}

output "lb_security_group_id" {
  value = module.sg_https_lb.security_group_id
}
output "target_group_attachments"{
  value = aws_lb_target_group_attachment.tg_attachments
}

output "complete"{
  value = {for index, value in flatten([for tg in aws_lb_target_group.target_groups: [
    for id in lookup(var.host_routing_map, tg.name).instance_ids: {
      arn = tg.arn
      instance = id
    }
  ]]): index => value}
}

output "zero_no_tomap"{
  value = flatten([for tg in aws_lb_target_group.target_groups: [
    for id in lookup(var.host_routing_map, tg.name).instance_ids: {
      arn = tg.arn
      instance = id
    }
  ]])
}

output "one_no_flatten"{
  value = [for tg in aws_lb_target_group.target_groups: [
    for id in lookup(var.host_routing_map, tg.name).instance_ids: {
      arn = tg.arn
      instance = id
    }
  ]]
}

