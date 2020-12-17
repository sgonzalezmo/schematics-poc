locals {
  system_lower      = lower(var.system)
  environment_lower = lower(var.environment)
  vpc_name          = "${local.system_lower}-${local.environment_lower}-vpc"
  vpc_tags          = ["system:${local.system_lower}", "environment:${local.environment_lower}"]
}

resource "ibm_is_vpc" "vpc" {
  name                      = local.vpc_name
  address_prefix_management = "auto"
  tags                      = local.vpc_tags
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
