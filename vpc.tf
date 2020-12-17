resource "ibm_is_vpc" "vpc1" {
  name                      = "${lower(var.system)}-${lower(var.environment)}-vpc"
  address_prefix_management = "auto"
  tags                      = [var.system, var.environment]
}
