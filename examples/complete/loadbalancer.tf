module "alb" {
  source                      = "../../modules/alb/"
  tls_certificate_arn         = var.tls_certificate_arn
  emr_cluster_id              = module.emr-spark.tamr_emr_cluster_id
  ec2_instance_id             = module.tamr-vm.tamr_instance.ec2_instance_id
  master_ids                  = data.aws_instances.masters.ids
  vpc_id                      = module.tamr_networking.vpc_id
  subnet_ids                  = module.tamr_networking.load_balancing_subnet_ids
  tags                        = var.tags
  master_fleet_instance_count = 1
  enable_host_routing = var.enable_host_routing
  host_routing_map = {
    "tamr" = {
      instance_ids = [module.tamr-vm.tamr_instance.ec2_instance_id]
      hosts        = ["tamr.*.*"]
      port         = var.tamr_unify_port
    }
    "dms" = {
      instance_ids = [module.tamr-vm.tamr_instance.ec2_instance_id]
      hosts        = ["dms.*.*"]
      port         = var.tamr_dms_port
    }
    "hbase" = {
      instance_ids = data.aws_instances.masters.ids
      hosts        = ["hbase.*.*"]
      port         = 16010
    }
    "ganglia" = {
      instance_ids = data.aws_instances.masters.ids
      hosts        = ["ganglia.*.*"]
      port         = 80
    }
    "spark" = {
      instance_ids = data.aws_instances.masters.ids
      hosts        = ["spark.*.*"]
      port         = 18080
    }
  }
}

data "aws_instances" "masters" {

  filter {
    name   = "tag:aws:elasticmapreduce:job-flow-id"
    values = [module.emr-spark.tamr_emr_cluster_id]
  }
  filter {
    name   = "tag:aws:elasticmapreduce:instance-group-role"
    values = ["MASTER"]
  }
}
