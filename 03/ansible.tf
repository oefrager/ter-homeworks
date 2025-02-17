resource "local_file" "hosts_template" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers   = yandex_compute_instance.count
    bdservers    = yandex_compute_instance.db
    disk_servers = yandex_compute_instance.storage
  })
  filename = "${abspath(path.module)}/hosts.cfg"
}

#provisioner "<provisioner type>" {
#command 1
#command 2
#}
