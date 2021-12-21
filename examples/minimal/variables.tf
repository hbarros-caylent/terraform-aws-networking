variable "vpc_cidr_block" {
  type = string
}
variable "ingress_cidr_blocks" {
  type = list(string)
}
variable "data_subnet_cidr_blocks" {
  type = list(string)
}
variable "application_subnet_cidr_block" {
  type = string
}
variable "compute_subnet_cidr_block" {
  type = string
}

variable "availability_zones" {
  type        = list(string)
  description = "The list of availability zones where we should deploy resources"
}

variable "create_public_subnets" {
  type = bool
}
variable "create_load_balancing_subnets" {
  type = bool
}
variable "enable_nat_gateway" {
  type = bool
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
