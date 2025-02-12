###VM vars

variable  "vm_web_image" {
  type        = string
  description = "ubuntu release name"
  default     = "ubuntu-2004-lts"
}

variable "vm_web_instance" {
  type = object({
    name           = string
    platform_id    = string
    cores          = number
    memory         = number
    core_fraction  = number
  })
  default = {  
    name           = "netology-develop-platform-web"
    platform_id    = "standard-v3"
    cores          = 2
    memory         = 1
    core_fraction  = 20    
   
  }
}

###cloud vars

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
  description = "VPC network & subnet name"
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = "ssh-keygen -t ed25519"
}
