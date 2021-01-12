locals {
  system         = "syste"
  environment    = "pre"
  resource_group = "schematics-poc-rg"
}

module "vpc" {
  source = "./vpc"

  system      = local.system
  environment = local.environment

  subnets_cidr = {
    "eu-de-1" = "172.16.1.0/24"
    "eu-de-2" = "172.16.2.0/24"
  }

  resource_group = local.resource_group
}

module "webservers_zone1" {
  source = "./vm"

  system      = local.system
  environment = local.environment

  server_count   = 1
  vpc            = module.vpc.vpc_id
  zone           = "eu-de-1"
  profile        = "cx2-2x4"
  subnet         = module.vpc.subnets_id["eu-de-1"]
  resource_group = local.resource_group
}

/*
resource "null_resource" "webservers_zone1_cluster" {
  count = 1

  connection {
    host = element(module.webservers_zone1.primary_ipv4_address, count.index)
  }

  provisioner "remote-exec" {
    inline = [
      "echo Hola",
    ]
  }
}
*/

module "webservers_zone2" {
  source = "./vm"

  system      = local.system
  environment = local.environment

  server_count   = 1
  vpc            = module.vpc.vpc_id
  zone           = "eu-de-2"
  profile        = "cx2-2x4"
  subnet         = module.vpc.subnets_id["eu-de-2"]
  resource_group = local.resource_group
}
