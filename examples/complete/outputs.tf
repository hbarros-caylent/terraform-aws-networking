output "alb_url" {
  value = "https://${module.alb.load_balancer.lb_dns_name}"
}

output "target_group_attachments" {
  value = module.alb.target_group_attachments
}

output "complete" {
  value = module.alb.complete
}

output "zero_no_tomap" {
  value = module.alb.zero_no_tomap
}

output "one_no_flatten" {
  value = module.alb.one_no_flatten
}

