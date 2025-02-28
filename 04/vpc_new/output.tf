output "vpc_network" {
  value       = yandex_vpc_network.network
}

output "vpc_subnet" {
  value       = yandex_vpc_subnet.subnet
}

output "vpc_zone" {
  value       = yandex_vpc_subnet.zone
}