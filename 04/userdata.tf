data template_file "userdata" {
  template = file("${path.module}/cloud-init.yml")

  vars = {
  #  username           = var.username
    ssh_public_key     = file(var.vms_ssh_root_key)
  #  packages           = jsonencode(var.packages)
  }
}
