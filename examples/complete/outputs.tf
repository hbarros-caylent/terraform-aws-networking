output "alb_url" {
  value = "https://${module.alb.load_balancer.lb_dns_name}"
}
