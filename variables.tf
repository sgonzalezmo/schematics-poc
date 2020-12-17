variable "ibmcloud_region" {
  type        = string
  description = "Preferred IBM Cloud region to use for your infrastructure"
  default     = "eu-de"
}

variable "system" {
  type        = string
  description = ""
}

variable "environment" {
  type        = string
  description = ""
}
