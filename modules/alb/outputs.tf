output "load_balancer" {
  value       = aws_lb.alb
  description = "Load balancer object"
}

output "lb_security_group_id" {
  value       = module.sg_https_lb.security_group_id
  description = "Security group ID of the loadbalancer"
}

output "target_groups" {
  #value = local.target_group_map
  value       = aws_lb_target_group.target_groups
  description = "Target groups used for each service"
}

output "target_group_attachments" {
  value = aws_lb_target_group_attachment.tg_attachments
  #value = ""
  description = "Target group attachments to connect target groups with instances"
}
