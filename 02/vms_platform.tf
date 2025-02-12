###VM vars

variable  "vm_db_image" {
  type        = string
  description = "ubuntu release name"
  default     = "ubuntu-2004-lts"
}

variable "vm_db_instance" {
  type = object({
    name           = string
    platform_id    = string
    cores          = number
    memory         = number
    core_fraction  = number
  })
  default = {  
    name           = "netology-develop-platform-db"
    platform_id    = "standard-v3"
    cores          = 2
    memory         = 2
    core_fraction  = 20    
   
  }
}

###cloud vars

variable "default_zone_db" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr_db" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
        
variable "vpc_name_db" {
  type        = string
  default     = "develop_db"
  description = "VPC network & subnet name"
}
