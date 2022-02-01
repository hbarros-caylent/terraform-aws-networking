variable "vpc_cidr_block" {
  type        = string
  description = "The cidr range for the vpc"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "The cidr range that will be accessing the tamr vm"
  default     = ["0.0.0.0/0"]
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

variable "availability_zones" {
  type        = list(string)
  description = "The list of availability zones where we should deploy resources"
}

variable "create_public_subnets" {
  type        = bool
  description = "Enable the creation of public subnets for internet facing resources"
  default     = false
}

variable "create_load_balancing_subnets" {
  type        = bool
  description = "Enable the creation of load balancing subnets for deploying a load balancer"
  default     = false
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable the creation of a NAT gateway"
  default     = false
}

variable "name_prefix" {
  type        = string
  description = ""
  default     = "tamr-"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default = {
    "Name" : "tamr-vpc",
    "application" : "tamr",
    "Terraform" : "true"
  }
}
