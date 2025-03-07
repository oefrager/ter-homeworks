terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "s3" {
    endpoints = { s3 = "https://storage.yandexcloud.net" }
    bucket    = "tfstate-backet"
    region    ="ru-central1"
    key       = "terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gatq458526r0g2j502/etntrtcrf5nsu7sf49s7"
    dynamodb_table    = "tfstate-lock"
  }
  required_version = "~>1.8.4"
}

provider "yandex" {
#  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  service_account_key_file = file("~/.authorized_key.json")
  zone      = var.default_zone
}

