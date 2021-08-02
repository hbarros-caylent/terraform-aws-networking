variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "The cidr range that will be accessing the load_balancer"
  default     = ["0.0.0.0/0"]
}

variable "tls_certificate_arn" {
  type        = string
  description = "The tls certificate ARN"
}

variable "name-prefix" {
  type        = string
  description = ""
  default     = "tamr-"
}

variable "ec2_instance_id" {
  type        = string
  description = "The Tamr VM instance id"
}

variable "vpc_id" {
    type = string
    description = "The id of the VPC where we will deploy the load balancer"
}

variable "subnet_ids" {
    type = list(string)
    description = "The ids of the subnets where we will deploy the load balancer"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "tamr_unify_port" {
  type        = string
  description = "Identifies the default access HTTP port"
  default     = "9100"
}
