output "vpc_network" {
  value       = yandex_vpc_network.network_id
}

output "vps_subnet" {
  value       = yandex_vpc_subnet.subnet_id
}