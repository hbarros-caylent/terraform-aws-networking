variable "availability_zones" {
  type        = list(string)
  description = "The list of availability zones where we should deploy resources"
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
