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
