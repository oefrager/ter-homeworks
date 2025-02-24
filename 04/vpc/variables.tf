variable "env_name" {
  type    = string
  description = "networ&subnet names for vpc"
}

variable "zone" {
  type        = string
  description = "subnet zones for vpc"
}

variable "v4_cidr_blocks" {
  type        = list(string)
  description = "subnet blocks for vpc"
}
