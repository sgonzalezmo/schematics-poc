module "vpc_module_1" {
  source = "./vpc"

  system      = "abcde"
  environment = "pre"

  subnets_cidr = {
    "eu-de-1" = "172.16.1.0/24"
    "eu-de-2" = "172.16.2.0/24"
  }
}
