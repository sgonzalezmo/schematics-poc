variable "system" {
  type        = string
  description = "System name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "server_count" {
  type        = number
  description = ""
}

variable "vpc" {
  type        = string
  description = ""
}

variable "zone" {
  type        = string
  description = ""
}

variable "profile" {
  type        = string
  description = ""
}

variable "subnet" {
  type        = string
  description = ""
}

variable "os" {
  type        = string
  description = ""
  default     = "rh7"
}

variable "resource_group" {
  type = string
}
