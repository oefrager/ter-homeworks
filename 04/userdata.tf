data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    username           = var.vms_ssh_root_name
    ssh_public_key     = file(var.vms_ssh_root_key)
  #  packages           = jsonencode(var.packages)
  }
}
