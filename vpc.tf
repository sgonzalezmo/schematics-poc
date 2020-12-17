resource "ibm_is_vpc" "vpc1" {
  name                      = "${var.system}-${var.environment}-vpc"
  address_prefix_management = "auto"
}
