variable "system" {
  type        = string
  description = "System name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "subnets_cidr" {
  type        = map(string)
  description = "A map of zones (key) and CIDRs blocks (value) to use"
}

variable "resource_group" {
  type = string
}
