data "ibm_is_ssh_key" "sshkey" {
  name = "schematics-lab-ssh-key"
}

locals {
  images = {
    "rh7" = "r010-931515d2-fcc3-11e9-896d-3baa2797200f"
    "rh8" = "r010-c2c67564-27a3-47e5-8f2f-faa363b9b353"
  }
  zone_acr = {
    "eu-de-1" = "ed1"
    "eu-de-2" = "ed2"
    "eu-de-3" = "ed3"
  }
  sys_lwr = lower(var.system)
  env_lwr = lower(var.environment)
}

resource "ibm_is_instance" "vms" {
  count   = var.server_count
  name    = "${var.system}-${local.env_lwr}-${lookup(local.zone_acr, var.zone)}-vm${count.index + 1}"
  image   = lookup(local.images, var.os)
  profile = var.profile

  primary_network_interface {
    name   = "eth1"
    subnet = var.subnet
  }

  vpc  = var.vpc
  zone = var.zone

  keys = [data.ibm_is_ssh_key.sshkey.id]

  tags = ["system:${local.sys_lwr}", "environment:${local.env_lwr}"]
}
