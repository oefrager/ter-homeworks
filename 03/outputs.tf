output "webservers" {
  value = [for i in yandex_compute_instance.count[*] : {
    name  = i.name
    id    = i.id
    fqdn  = i.fqdn
  }]
}

output "databases" {
  value = [for v in yandex_compute_instance.db : {
    name = v.name
    id   = v.id
    fqdn = v.fqdn
  }]
}