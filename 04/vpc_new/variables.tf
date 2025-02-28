variable "env_name" {
  type    = string
  description = "networ&subnet names for vpc"
}

#variable "zone" {
#  type        = string
#  description = "subnet zones for vpc"
#}

#variable "cidr" {
#  type        = list(string)
#  description = "subnet blocks for vpc"
#}

variable "subnets" {
  type = list(object({
    zone = string,
    cidr = string
  }))
#  default = []
}
