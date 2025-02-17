###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable  "vm_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu release name"
}

variable "vms_resources" {      ###VM WEB & STORAGE vars
  type = map(object({
    platform_id    = string
    type_hdd       = string
    cores          = number
    memory         = number
    core_fraction  = number
  }))
  default = {
    web = {
      platform_id    = "standard-v1"
      type_hdd       = "network-hdd"
      cores          = 2
      memory         = 1
      core_fraction  = 5
    },
    disk = {
      platform_id    = "standard-v1"
      type_hdd       = "network-hdd"
      cores          = 2
      memory         = 2
      core_fraction  = 20
    }
  }
}

variable "vms_resources_db" {     ###VM BD vars
  type = map(object({
    name           = string
    platform_id    = string
    disk_volume    = number
    cores          = number
    memory         = number
    core_fraction  = number
  }))
  default = {
    main = {
      name           = "main"
      platform_id    = "standard-v1"
      disk_volume    = 5
      cores          = 2
      memory         = 1
      core_fraction  = 5
    },
    replica = {
      name           = "replica"
      platform_id    = "standard-v1"
      disk_volume    = 10
      cores          = 4
      memory         = 2
      core_fraction  = 20
    }
  }
}

variable "disk_volume" {        ###DISK vars
  type        = string
  default     = 1
  description = "additional disk size"
}