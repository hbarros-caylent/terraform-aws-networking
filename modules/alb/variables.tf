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

variable "master_ids" {
  type        = list(string)
  description = "The Tamr VM instance id"
  default = []
}

variable "emr_cluster_id" {
  type        = string
  description = "The EMR Master instance id"
  default = ""
}

variable "master_fleet_instance_count"{
  type = number
  description = "Number of on-demand and spot master instances configured"
}

variable "host_routing_map" {
  type        = map(object({
                        instance_ids = list(string)
                        hosts= list(string)
                        port = number
                      }))
  description = "Map with hosts that should be used for routing"
  default = {
    "tamr" = {
      instance_ids = ["i-000000"]
      hosts = ["tamr.*.*"]
      port = 9100
    }
  }
}

variable "vpc_id" {
  type        = string
  description = "The id of the VPC where we will deploy the load balancer"
}

variable "subnet_ids" {
  type        = list(string)
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

variable "tamr_dms_port" {
  type        = string
  description = "Identifies the DMS access HTTP port"
  default     = "9155"
}

variable "tamr_dms_hosts" {
  type        = list(string)
  description = "Specify list of host headers to use in host based routing"
  default     = []
}

variable "enable_host_routing" {
  type        = bool
  description = "Enabled the DMS proxying on the port specified in tamr_dms_port"
  default     = false
}
