output "vpc_id" {
  value       = ibm_is_vpc.vpc.id
  description = "The vpc id"
}

output "subnets_id" {
  # Result is a map from instance zone to subnet id, such as:
  #  {"eu-de-1" = "i-1234", "eu-de-2" = "i-5678"}
  value = {
    for instance in ibm_is_subnet.vpc_subnet :
    instance.zone => instance.id
  }
}
