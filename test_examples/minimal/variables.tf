variable "vpc_cidr_block" {
  type        = string
  description = "The cidr range for the vpc"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "The cidr range that will be accessing the tamr vm."
  # default     = ["0.0.0.0/0"]
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
  #   default     = ["0.0.0.0/0", "0.0.0.0/0"]
}

variable "availability_zones" {
  type        = list(string)
  description = "The list of availability zones where we should deploy resources"
  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Please provide only two availability zones."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}
