data "ibm_resource_group" "rg" {
  name = var.resource_group
}

locals {
  sys_lwr = lower(var.system)
  env_lwr = lower(var.environment)
}

resource "ibm_is_vpc" "vpc" {
  name                      = "${local.sys_lwr}-${local.env_lwr}-vpc"
  address_prefix_management = "auto"
  tags                      = ["system:${local.sys_lwr}", "environment:${local.env_lwr}"]
  resource_group            = data.ibm_resource_group.rg.id
}

resource "ibm_is_vpc_address_prefix" "vpc-ap" {
  for_each = var.subnets_cidr
  name     = "${each.key}-ap"
  zone     = each.key
  vpc      = ibm_is_vpc.vpc.id
  cidr     = each.value
}

resource "ibm_is_subnet" "vpc_subnet" {
  for_each        = var.subnets_cidr
  name            = "${each.key}-subnet"
  vpc             = ibm_is_vpc.vpc.id
  zone            = each.key
  ipv4_cidr_block = each.value
  depends_on      = [ibm_is_vpc_address_prefix.vpc-ap]
  resource_group  = data.ibm_resource_group.rg.id
}
