# Description

This example deploys the following resources:
- VPC
- Web Security group

In this example we creates a VPC with an interface VPC endpoint, just for the purpose if this exaple we also creates a security group to allow the proper configuration of the interface endpoint.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_zones | The list of availability zones where we should deploy resources | `list(string)` | n/a | yes |
| name\_prefix | n/a | `string` | `"tamr-"` | no |
| tags | A map of tags to add to all resources. | `map(string)` | <pre>{<br>  "Name": "tamr-vpc",<br>  "Terraform": "true",<br>  "application": "tamr"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| tamr\_networking | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
