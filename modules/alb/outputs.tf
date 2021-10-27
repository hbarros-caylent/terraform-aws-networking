output "load_balancer" {
  value = aws_lb.alb
}

output "lb_security_group_id" {
  value = module.sg_https_lb.security_group_id
}

output "target_groups" {
  value = local.target_group_map
}

output "target_group_attachments" {
  value = aws_lb_target_group_attachment.tg_attachments
}
