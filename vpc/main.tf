locals {
  sys_lwr = lower(var.system)
  env_lwr = lower(var.environment)
}

resource "ibm_is_vpc" "vpc" {
  name                      = "vpc-${local.sys_lwr}-${local.env_lwr}"
  address_prefix_management = "auto"
  tags                      = ["system:${local.sys_lwr}", "environment:${local.env_lwr}"]
}

resource "ibm_is_vpc_address_prefix" "vpc-ap" {
  for_each = var.subnets_cidr
  name     = "vpc-ap-${each.key}"
  zone     = each.key
  vpc      = ibm_is_vpc.vpc.id
  cidr     = each.value
}

resource "ibm_is_subnet" "vpc_subnet" {
  for_each        = var.subnets_cidr
  name            = "vpc-subnet-${each.key}"
  vpc             = ibm_is_vpc.vpc.id
  zone            = each.key
  ipv4_cidr_block = each.value
  depends_on      = [ibm_is_vpc_address_prefix.vpc-ap]
}
