variable "vpc_name" {
  type    = string
  default = ""
}

variable "env" {
  type    = string
  default = ""
}

variable "private_subnet_id_a" {
  type    = string
  default = ""
}

variable "private_subnet_id_b" {
  type    = string
  default = ""
}

variable "ecs_security_group" {
  type    = string
  default = ""
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "target_id" {
  type    = string
  default = ""
}
