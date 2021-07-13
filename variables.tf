variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "The cidr range that will be accessing the tamr vm."
  default     = ["0.0.0.0/0"]
}

variable "vpc_cidr_block" {
  type        = string
  description = "The cidr range for the vpc"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type        = list(string)
  description = "The list of availability zones where we should deploy resources (At least 2)"
}

variable "create_public_subnets" {
  type        = bool
  description = "Enable the creation of public subnets for accessing Tamr from the internet"
  default     = false
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable the creation of a NAT gateway"
  default     = false
}
