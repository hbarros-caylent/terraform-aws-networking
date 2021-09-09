# TLS ALB Example
The following example will deploy the necessary resources to access Tamr using HTTPS.

# Description
This example deploys the following resources:
- VPC
- NAT Gateway
- Tamr VM instance with nginx for validation purposes.
- Application load_balancer
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.1 |
| aws | >= 3.40 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.40 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_zones | The list of availability zones where we should deploy resources | `list(string)` | n/a | yes |
| key\_pair | n/a | `string` | n/a | yes |
| tls\_certificate\_arn | The tls certificate ARN | `string` | n/a | yes |
| ami\_id | The AMI to use for the tamr vm | `string` | `""` | no |
| enable\_dms | Enabled the DMS proxying on the port specified in tamr\_dms\_port | `bool` | `true` | no |
| ingress\_cidr\_blocks | The cidr range that will be accessing the tamr vm | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| name-prefix | n/a | `string` | `"tamr-"` | no |
| tags | A map of tags to add to all resources. | `map(string)` | <pre>{<br>  "Name": "tamr-vpc",<br>  "Terraform": "true",<br>  "application": "tamr"<br>}</pre> | no |
| tamr\_dms\_hosts | Specify list of host headers to use in host based routing | `list(string)` | `[]` | no |
| tamr\_dms\_port | Identifies the DMS access HTTP port | `string` | `"9155"` | no |
| tamr\_unify\_port | Identifies the default access HTTP port | `string` | `"9100"` | no |

## Outputs

| Name | Description |
|------|-------------|
| alb\_url | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
