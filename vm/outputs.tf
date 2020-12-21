output "primary_ipv4_address" {
  value = ibm_is_instance.vm[*].primary_network_interface[0].primary_ipv4_address
}
