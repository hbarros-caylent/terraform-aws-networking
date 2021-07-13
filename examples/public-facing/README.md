# Public Facing Example

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_id | The AMI to use for the tamr vm | `string` | n/a | yes |
| availability\_zones | The list of availability zones where we should deploy resources | `list(string)` | n/a | yes |
| key\_pair | n/a | `string` | n/a | yes |
| ingress\_cidr\_blocks | The cidr range that will be accessing the tamr vm | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| name-prefix | n/a | `string` | `"public-facing-example"` | no |
| tls\_certificate\_arn | The tls certificate ARN | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| alb\_url | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

