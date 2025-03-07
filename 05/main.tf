module "vpc_dev" {
  source       = "./modules/vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}

module "marketing" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing"
  network_id     = module.vpc_dev.vpc_network.id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_dev.vpc_subnet[0].id]
  instance_name  = "webserv"
  instance_count = 1
  image_family   = var.image_family
  public_ip      = true

  labels = {
    project = "marketing"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

