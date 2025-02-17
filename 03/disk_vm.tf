data "yandex_compute_image" "ubuntu_disk" {
  family = var.vm_image
}

resource "yandex_compute_disk" "vm-disk" {
  count       = 3
  name        = "disk-${count.index}"
  type        = var.vms_resources.disk.type_hdd
  size        = var.disk_volume
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.vms_resources.disk.platform_id
  resources {
    cores         = var.vms_resources.disk.cores
    memory        = var.vms_resources.disk.memory
    core_fraction = var.vms_resources.disk.core_fraction
    }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.disk.type_hdd
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.vm-disk.*.id
    content {
      disk_id = secondary_disk.value
      auto_delete = true
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