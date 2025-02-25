  terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

resource "yandex_vpc_network" "network_id" {
  name = var.env_name
}
resource "yandex_vpc_subnet" "subnet_id" {
  name           = var.env_name
  zone           = var.zone
  network_id     = yandex_vpc_network.network_id.id
  v4_cidr_blocks = var.v4_cidr_blocks
}
