# Tamr Networking Module
Tamr’s AWS resources need to be launched into an existing Virtual Private Cloud (VPC) setup that meets certain requirements. The reference network architecture here described is designed to support the Tamr AWS scale-out deployment following security best practices.

## Description
The Tamr VPC spans two Availability Zones (AZs) and includes the following resources by default:
- Application subnet (1): hosts the EC2 Instance where the Tamr application is deployed (also known as Tamr VM).
- Compute subnet (1): hosts the Amazon EMR clusters and is launched in the same AZ as the Application subnet.
- Data subnets (2): used for deploying a Multi-AZ PostgreSQL Relational Database Service (RDS) instance and a Multi-AZ Amazon ElasticSearch (ES) Service domain.
- S3 Gateway VPC Endpoint: provides a secure, reliable connection to Amazon S3 without requiring an Internet gateway or NAT device.
- Network ACLs: grants access to subnets to only the resources they need and acts as another layer of security for the VPC.

## Examples
### Basic
Includes the most basic VPC that can support a Tamr deployment.
### Complete
Includes a VPC with all the variables configured.

### Public facing
Includes the following resources:
- Application Loadbalancer
- Loadbalancing subnets (2)
- NAT gateway
- HTTPS
- The Tamr-VM with a sample website for validation.

- [ALB With SSL](./examples/ssl-alb)
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
| vpc\_cidr\_block | The cidr range for the vpc | `string` | n/a | yes |
| application\_subnet\_cidr\_block | The application subnet's CIDR range | `string` | `"10.0.0.0/24"` | no |
| availability\_zones | The list of availability zones where we should deploy resources (At least 2) | `list(string)` | `[]` | no |
| compute\_subnet\_cidr\_block | The data subnet CIDR range | `string` | `"10.0.1.0/24"` | no |
| create\_loadbalancing\_subnets | Enable the creation of loadbalancing subnets for deploying a loadbalancer | `bool` | `false` | no |
| create\_public\_subnets | Enable the creation of public subnets for internet facing resources | `bool` | `false` | no |
| data\_subnet\_cidr\_blocks | The data subnet's CIDR range | `list(string)` | <pre>[<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| enable\_nat\_gateway | Enable the creation of a NAT gateway | `bool` | `false` | no |
| ingress\_cidr\_blocks | The cidr range that will be accessing the tamr vm. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| loadbalancing\_subnets\_cidr\_blocks | The loadbalancing subnets' CIDR range | `list(string)` | <pre>[<br>  "10.0.4.0/24",<br>  "10.0.5.0/24"<br>]</pre> | no |
| public\_subnets\_cidr\_blocks | The public subnets' CIDR range | `list(string)` | <pre>[<br>  "10.0.100.0/24",<br>  "10.0.101.0/24"<br>]</pre> | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| application\_subnet\_cidr\_block | n/a |
| application\_subnet\_id | n/a |
| compute\_subnet\_id | n/a |
| data\_subnet\_group\_ids | n/a |
| loadbalancing\_subnet\_ids | n/a |
| public\_subnet\_ids | n/a |
| tamr\_ec2\_availability\_zone | n/a |
| vpc\_cidr\_block | n/a |
| vpc\_id | n/a |

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
