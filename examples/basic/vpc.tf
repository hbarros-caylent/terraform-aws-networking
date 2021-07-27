module "tamr_networking" {
    //source = "git::https://github.com/Datatamer/terraform-aws-networking.git?ref=1.0"
    source = "../../"
    vpc_cidr_block = "10.0.0.0/16"
    availability_zones = ["us-west-1a", "us-west-1b"]
    create_public_subnets = true
}
