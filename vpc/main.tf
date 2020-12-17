locals {
  system_lower      = lower(var.system)
  environment_lower = lower(var.environment)
}

resource "ibm_is_vpc" "vpc1" {
  name                      = "${local.system_lower}-${local.environment_lower}-vpc"
  address_prefix_management = "auto"
  tags                      = ["system:${local.system_lower}", "environment:${local.environment_lower}"]
}
