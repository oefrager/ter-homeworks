variable "env_name" {
  type    = string
  description = "network&subnet names for vpc"
}

variable "subnets" {
  type = list(object({
    zone = string,
    cidr = string
  }))
#  default = []
}
