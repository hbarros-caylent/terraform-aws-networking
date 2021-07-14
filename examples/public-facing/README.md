# Public Facing Example

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.1 |
| aws | >= 3.40 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key\_pair | n/a | `string` | n/a | yes |
| ami\_id | The AMI to use for the tamr vm | `string` | `"ami-09a51f80998749f6d"` | no |
| availability\_zones | The list of availability zones where we should deploy resources | `list(string)` | <pre>[<br>  "us-west-1a",<br>  "us-west-1b"<br>]</pre> | no |
| ingress\_cidr\_blocks | The cidr range that will be accessing the tamr vm | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| name-prefix | n/a | `string` | `"public-facing-example"` | no |
| tags | A map of tags to add to all resources. Replaces `additional_tags`. | `map(string)` | <pre>{<br>  "application": "tamr_public_facing_example"<br>}</pre> | no |
| tls\_certificate\_arn | The tls certificate ARN | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| alb\_url | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

