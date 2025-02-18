data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_image
}

resource "yandex_compute_instance" "db" {
  for_each    = var.vms_resources_db
  name        = each.value.name
  hostname    = each.value.hostname
  platform_id = each.value.platform_id
    resources {
      cores         = each.value.cores
      memory        = each.value.memory
      core_fraction = each.value.core_fraction
    }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = each.value.disk_volume
    }
  }
  
  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
    }

  metadata = local.metadata
}