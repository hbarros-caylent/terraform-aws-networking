module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id = module.vpc.vpc_id

  endpoints = {
    s3 = {
      service_type    = "Gateway"
      service         = "s3"
      tags            = { Name = "s3-vpc-endpoint" }
      route_table_ids = flatten([module.vpc.private_route_table_ids[0], [aws_route_table.compute_subnet_rt.id]])
    }
  }
  tags = var.tags
}
