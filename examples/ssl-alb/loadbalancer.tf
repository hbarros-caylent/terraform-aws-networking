module "alb" {
    source = "../../modules/alb/"
    tls_certificate_arn = var.tls_certificate_arn
    ec2_instance_id = module.tamr-vm.tamr_instance.ec2_instance_id
    vpc_id = module.tamr_networking.vpc_id
    subnet_ids = module.tamr_networking.loadbalancing_subnet_ids
    tags = var.tags
}
