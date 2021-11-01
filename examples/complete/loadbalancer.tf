locals{
  counter = sum(local.counter2)
  counter2 = tolist([for service, data in local.host_routing_map:
    data.length
  ])
  host_routing_map = {
    "tamr" = {
      length       = 1 //only used for counting when creating target_group_attachments
      instance_ids = [module.tamr-vm.tamr_instance.ec2_instance_id]
      hosts        = ["tamr.*.*"]
      port         = var.tamr_unify_port
    }
    "dms" = {
      length       = 1
      instance_ids = [module.tamr-vm.tamr_instance.ec2_instance_id]
      hosts        = ["dms.*.*"]
      port         = var.tamr_dms_port
    }
    "hbase" = {
      length       = 1
      instance_ids = data.aws_instances.masters.ids
      hosts        = ["hbase.*.*"]
      port         = 16010
    }
    "ganglia" = {
      length       = 1
      instance_ids = data.aws_instances.masters.ids
      hosts        = ["ganglia.*.*"]
      port         = 80
    }
    "spark" = {
      length       = 1
      instance_ids = data.aws_instances.masters.ids
      hosts        = ["spark.*.*"]
      port         = 18080
    }
  }
}

module "alb" {
  source                      = "../../modules/alb/"
  tls_certificate_arn         = var.tls_certificate_arn
  emr_cluster_id              = module.emr.tamr_emr_cluster_id
  ec2_instance_id             = module.tamr-vm.tamr_instance.ec2_instance_id
  master_instances = data.aws_instances.masters.ids
  vpc_id                      = module.tamr_networking.vpc_id
  subnet_ids                  = module.tamr_networking.load_balancing_subnet_ids
  tags                        = var.tags
  enable_host_routing         = var.enable_host_routing
  host_routing_map            = local.host_routing_map
  counter = local.counter
}


data "aws_instances" "masters" {

  filter {
    name   = "tag:aws:elasticmapreduce:job-flow-id"
    values = [module.emr.tamr_emr_cluster_id]
  }
  filter {
    name   = "tag:aws:elasticmapreduce:instance-group-role"
    values = ["MASTER"]
  }
}
