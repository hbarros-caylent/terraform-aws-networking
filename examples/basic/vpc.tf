module "tamr_vpc" {
    source = "git::https://github.com/Datatamer/terraform-aws-networking.git?ref=1.0"
    vpc_cidr_block = "10.0.0.0/16"
    availability_zones = ["us-east-1a", "us-east-1b"]
}
