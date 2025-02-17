data "yandex_compute_image" "ubuntu" {
  family = var.vm_image
}

resource "yandex_compute_instance" "count" {
  count       = 2
  name        = "web-${count.index+1}"
  hostname    = "web-${count.index+1}"
  platform_id = var.vms_resources.web.platform_id
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
    }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vms_resources.web.type_hdd
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