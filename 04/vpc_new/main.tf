terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

resource "yandex_vpc_network" "network" {
  name = var.env_name
}
#resource "yandex_vpc_subnet" "subnet" {
#  name           = var.env_name
#  zone           = [var.zone]
#  network_id     = yandex_vpc_network.network.id
#  v4_cidr_blocks = var.cidr
#}


resource "yandex_vpc_subnet" "subnet" {
#for_each = { for s in var.subnets: index(var.subnets,s)=> s }
#  name           = "${var.env_name}-${each.value.zone}"
  for_each       = {for i in var.subnets: i.zone => i}
  name           = "${var.env_name}-${each.key}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [each.value.cidr]
}