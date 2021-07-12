output "alb_url" {
  value = var.tls_certificate_arn == "" ? "http://${module.alb.lb_dns_name}" : "https://${module.alb.lb_dns_name}"
  }