variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Subnet IDs"
  type        = list(string)
}

variable "bastion_security_group_id" {
  description = "Bastion Security Group ID"
  type        = string
}

variable "availability_zones" {
  description = "List of Availability Zones to use for resources"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
