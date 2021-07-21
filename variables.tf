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

variable "data_subnet_cidr_blocks" {
  type        = list(string)
  description = "The data subnet's CIDR range"
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "application_subnet_cidr_block" {
  type        = string
  description = "The application subnet's CIDR range"
  default     = "10.0.0.0/24"
}

variable "compute_subnet_cidr_block" {
  type        = string
  description = "The data subnet CIDR range"
  default     = "10.0.1.0/24"
}

variable "public_subnets_cidr_blocks" {
  type        = list(string)
  description = "The public subnets' CIDR range"
  default     = ["10.0.100.0/24", "10.0.101.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = "The list of availability zones where we should deploy resources (At least 2)"
  default     = []
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

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}
