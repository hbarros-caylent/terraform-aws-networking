variable "vpc_cidr_block" {
  type        = string
  description = "The cidr range for the vpc"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "The cidr range that will be accessing the tamr vm."
}

variable "name_prefix" {
  type        = string
  description = "A prefix to add to the names of all created resources."
}

variable "data_subnet_cidr_blocks" {
  type        = list(string)
  description = "The data subnet's CIDR range"
}

variable "application_subnet_cidr_block" {
  type        = string
  description = "The application subnet's CIDR range"
}

variable "compute_subnet_cidr_block" {
  type        = string
  description = "The data subnet CIDR range"
}

variable "public_subnets_cidr_blocks" {
  type        = list(string)
  description = "The public subnets' CIDR range"
}

variable "create_public_subnets" {
  type        = bool
  description = "Enable the creation of public subnets for internet facing resources"
}

variable "create_load_balancing_subnets" {
  type        = bool
  description = "Enable the creation of load balancing subnets for deploying a load balancer"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable the creation of a NAT gateway"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}
