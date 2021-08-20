# Tamr ALB Module
In order to access Tamr using TLS encryption, we recommend using an Application Load Balancer. This module provides the resources necessary to make the deployment easy.

## Description
This module creates the following resources:
- Load Balancer with HTTP (80) to HTTPS(443) redirection
- Security Groups

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
| ec2\_instance\_id | The Tamr VM instance id | `string` | n/a | yes |
| subnet\_ids | The ids of the subnets where we will deploy the load balancer | `list(string)` | n/a | yes |
| tls\_certificate\_arn | The tls certificate ARN | `string` | n/a | yes |
| vpc\_id | The id of the VPC where we will deploy the load balancer | `string` | n/a | yes |
| enable\_dms | Enabled the DMS proxying on the port specified in tamr\_dms\_port | `bool` | `false` | no |
| ingress\_cidr\_blocks | The cidr range that will be accessing the load\_balancer | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| name-prefix | n/a | `string` | `"tamr-"` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| tamr\_dms\_hosts | Specify list of host headers to use in host based routing | `list(string)` | `[]` | no |
| tamr\_dms\_port | Identifies the DMS access HTTP port | `string` | `"9155"` | no |
| tamr\_unify\_port | Identifies the default access HTTP port | `string` | `"9100"` | no |

## Outputs

| Name | Description |
|------|-------------|
| lb\_security\_group\_id | n/a |
| load\_balancer | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Development
## Generating Docs
Run `make terraform/docs` to generate the section of docs around terraform inputs, outputs and requirements.

## Checkstyles
Run `make lint`, this will run terraform fmt, in addition to a few other checks to detect whitespace issues.
NOTE: this requires having docker working on the machine running the test

## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
