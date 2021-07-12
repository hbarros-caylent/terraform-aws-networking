# Tamr Networking Module

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ingress_cidr_blocks | n/a | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | yes |
| vpc_cidr_block | n/a | `string` | \"\" | no |
| availability_zones | n/a | `list(string)` | n/a | yes |
| create_public_subnets | n/a | `string` | n/a | yes |
| name-enable_nat_gateway | n/a | `string` | `"public-facing-example"` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The URL of the loadbalancer |
| ec2_subnet_id| The subnet id for the EMR nodes|
| tamr_ec2_subnet_id| The subnet id of the tamr vm|
| tamr_ec2_subnet_cidr_block| The cidr block of the tamr vm's subnet|
| rds_subnet_group_ids| Ids for the RDS subnet groups|
| tamr_ec2_availability_zone| The AZ of the tamr vm|
| public_subnet_ids| The ids of the public subnets|
