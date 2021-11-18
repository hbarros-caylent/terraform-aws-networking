module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id = module.vpc.vpc_id

  endpoints = {
    s3 = {
      service_type    = "Gateway"
      service         = "s3"
      tags            = {Name = format("%s-%s", var.name_prefix, "s3-vpc-endpoint")}
      route_table_ids = flatten([module.vpc.private_route_table_ids[0]])
    },
    elasticmapreduce = {
      service_type        = "Interface"
      service             = "elasticmapreduce"
      tags                = {Name = format("%s-%s", var.name_prefix, "emr-interface-endpoint")}
      private_dns_enabled = true
      security_group_ids  = [aws_security_group.interface_endpoint.id]
      subnet_ids          = [module.vpc.private_subnets[0]]
    },
  }
  tags = var.tags
}

resource "aws_security_group" "interface_endpoint" {
  description = "Sec Group created to be attached into interface Endpoint for Tamr EMR, it allows TCP traffic between the Tamr VM subnet and EMR cluster."

  ingress = [ {
    cidr_blocks = [ var.application_subnet_cidr_block ]
    description = "EMR API"
    from_port = 443
    to_port = 443
    protocol = "TCP"
  } ]
}
