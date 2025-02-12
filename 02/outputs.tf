output "VM_INFO" {
    value = {
        vm_web = {
            name = yandex_compute_instance.platform.name,
            fqdn = yandex_compute_instance.platform.fqdn,
            external_ip = yandex_compute_instance.platform.network_interface[0].nat_ip_address
        },
    
        vm_db = {
            name = yandex_compute_instance.db.name,
            fqdn = yandex_compute_instance.db.fqdn,
            external_ip = yandex_compute_instance.db.network_interface[0].nat_ip_address
        }
    }    
    description = "db attributes"
}
