

output "alb_url" {
  value = "https://${module.alb.load_balancer.dns_name}"
}

output "routing_map" {
  //value = local.host_routing_map
  value = module.alb.target_group_attachments
}