# Public Facing Example

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ingress_cidr_blocks | n/a | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | yes |
| tls_certificate_arn | n/a | `string` | \"\" | no |
| availability_zones | n/a | `list(string)` | n/a | yes |
| ami_id | n/a | `string` | n/a | yes |
| name-prefix | n/a | `string` | `"public-facing-example"` | no |
| key_pair | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb_url | The URL of the loadbalancer |

