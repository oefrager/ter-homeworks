module "vpc_develop" {
  source         = "./modules/vpc"
  env_name       = "develop"
  zone           = var.default_zone
  v4_cidr_blocks = ["10.0.1.0/24"]
}

module "marketing" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "marketing"
  network_id     = module.vpc_develop.vpc_network.id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_develop.vpc_subnet.id]
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

module "analytics" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "analytics"
  network_id     = module.vpc_develop.vpc_network.id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_develop.vpc_subnet.id]
  instance_name  = "stage"
  instance_count = 1
  image_family   = var.image_family
  public_ip      = true

  labels = { 
    project = "analytics"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}
