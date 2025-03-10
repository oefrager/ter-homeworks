##cloud vars
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

###common vars
variable "vms_ssh_root_key" {
  type        = list(string)
  default     = ["~/.ssh/id_ed25519.pub"]
  description = "ssh-keygen -t ed25519"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "name image os"
}



###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}


###validation test
variable "ip_address" {
  description = "ip-адрес"
  type        = string
  default     = "1920.1680.0.1"  # wrong IP address
#  default     = "192.168.0.0/24"    # validate IP address
  validation {
    condition     = can(cidrhost(var.ip_address, 1))
    error_message = "Неверный ip-адрес"
  }
}

variable "ip_address_list" {
  description = "список ip-адресов"
  type        = list(string)
  default     = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]   # wrong list IP address
#  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]    # validate list IP address
  validation {
    condition = alltrue([for ip in var.ip_address_list: can(regex("^((25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)\\.?\\b){4}$", ip))])
    error_message = "Неверный список ip-адресов"
  }
}

