# Tamr Networking Module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 3.47.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.47.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_zones | The list of availability zones where we should deploy resources (At least 2) | `list(string)` | <pre>[<br>  "us-west-1a",<br>  "us-west-1b"<br>]</pre> | no |
| create\_public\_subnets | Enable the creation of public subnets for accessing Tamr from the internet | `bool` | `false` | no |
| enable\_nat\_gateway | Enable the creation of a NAT gateway | `bool` | `false` | no |
| ingress\_cidr\_blocks | The cidr range that will be accessing the tamr vm. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| vpc\_cidr\_block | The cidr range for the vpc | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| application\_subnet\_cidr\_block | n/a |
| application\_subnet\_id | n/a |
| compute\_subnet\_id | n/a |
| data\_subnet\_group\_ids | n/a |
| public\_subnet\_ids | n/a |
| tamr\_ec2\_availability\_zone | n/a |
| vpc\_cidr\_block | n/a |
| vpc\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
