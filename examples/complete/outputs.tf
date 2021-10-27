output "alb_url" {
  value = "https://${module.alb.load_balancer.dns_name}"
}
/*
output "desired" {
  value = module.alb.target_groups
}

output "alb"{
  value = module.alb.tg_attachments
}
*/
