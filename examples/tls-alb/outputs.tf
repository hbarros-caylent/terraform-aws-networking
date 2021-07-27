output "alb_url" {
  value = "https://${module.alb.loadbalancer.lb_dns_name}"
}
