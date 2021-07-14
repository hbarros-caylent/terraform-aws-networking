# Tamr Networking Module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.36 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.36 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application\_subnet\_cidr\_block | The application subnet's CIDR range | `string` | `"10.0.0.0/24"` | no |
| availability\_zones | The list of availability zones where we should deploy resources (At least 2) | `list(string)` | <pre>[<br>  "us-west-1a",<br>  "us-west-1b"<br>]</pre> | no |
| compute\_subnet\_cidr\_block | The data subnet CIDR range | `string` | `"10.0.1.0/24"` | no |
| create\_public\_subnets | Enable the creation of public subnets for accessing Tamr from the internet | `bool` | `false` | no |
| data\_subnet\_cidr\_blocks | The data subnet's CIDR range | `list(string)` | <pre>[<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| enable\_nat\_gateway | Enable the creation of a NAT gateway | `bool` | `false` | no |
| ingress\_cidr\_blocks | The cidr range that will be accessing the tamr vm. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| public\_subnets\_cidr\_blocks | The public subnets' CIDR range | `list(string)` | <pre>[<br>  "10.0.100.0/24",<br>  "10.0.101.0/24"<br>]</pre> | no |
| tags | A map of tags to add to all resources. Replaces `additional_tags`. | `map(string)` | `{}` | no |
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
