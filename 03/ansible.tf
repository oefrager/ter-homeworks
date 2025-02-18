resource "local_file" "hosts_template" {
  filename = "${abspath(path.module)}/hosts.cfg"
  content = templatefile("${path.module}/ansible.tftpl", {
    webservers   = yandex_compute_instance.count
    databases    = yandex_compute_instance.db
    storage      = [yandex_compute_instance.storage]
  })
}
