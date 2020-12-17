module "vpc_module_1" {
  source = "./vpc"

  system      = var.system
  environment = var.environment
}
