variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "The cidr range that will be accessing the tamr vm"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "The cidr ranges that will be accessible from EMR"
}

variable "tls_certificate_arn" {
  type        = string
  description = "The tls certificate ARN"
}

variable "availability_zones" {
  type        = list(string)
  description = "The list of availability zones where we should deploy resources"
}

variable "tamr_unify_port" {
  type        = string
  description = "Identifies the default access HTTP port"
  default     = "9100"
}

variable "tamr_dms_port" {
  type        = string
  description = "Identifies the DMS access HTTP port"
  default     = "9155"
}

variable "ami_id" {
  type        = string
  description = "The AMI to use for the tamr vm"
  default     = ""
}

variable "abac_valid_tags" {
  type        = map(list(string))
  description = "Valid tags for maintaining resources when using ABAC IAM Policies with Tag Conditions. Make sure `tags` contain a key value specified here."
  default     = {}
}

variable "name_prefix" {
  type        = string
  description = ""
  default     = "tamr-"
}

variable "key_pair" {
  type = string
}

variable "bucket_name_for_logs" {
  type        = string
  description = "S3 bucket name for cluster logs."
}

variable "bucket_name_for_root_directory" {
  type        = string
  description = "S3 bucket name for storing root directory"
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
