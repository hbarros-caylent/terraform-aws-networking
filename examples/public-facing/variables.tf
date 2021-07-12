variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "The cidr range that will be accessing the tamr vm"
  default     = ["0.0.0.0/0"]
}

variable "tls_certificate_arn" {
  type = string
  description = "The tls certificate ARN"
  default = ""
}

variable "availability_zones" {
  type = list(string)
  description = "The list of availability zones where we should deploy resources"
}

variable "ami_id" {
  type = string
  description = "The AMI to use for the tamr vm"
}

variable "name-prefix" {
  type = string
  description = ""
  default = "public-facing-example"
}

variable "key_pair" {
  type = string
}