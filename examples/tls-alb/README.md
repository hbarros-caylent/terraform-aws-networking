# TLS ALB Example
The following example will deploy the necessary resources to access Tamr using HTTPS.

# Description
This example deploys the following resources:
- VPC
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key\_pair | n/a | `string` | n/a | yes |
| tls\_certificate\_arn | The tls certificate ARN | `string` | n/a | yes |
| ami\_id | The AMI to use for the tamr vm | `string` | `""` | no |
| availability\_zones | The list of availability zones where we should deploy resources | `list(string)` | `[]` | no |
| ingress\_cidr\_blocks | The cidr range that will be accessing the tamr vm | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| name-prefix | n/a | `string` | `"tamr-"` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| alb\_url | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
