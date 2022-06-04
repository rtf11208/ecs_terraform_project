variable "image_id" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = ""
}

variable "ecs_security_group" {
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

variable "bastion_host_sg" {
  type    = string
  default = ""
}

variable "iam_instance_profile" {
  type    = string
  default = ""
}

variable "availability_zones" {
  type    = list(string)
  default = [""]
}

variable "public_subnet_id" {
  type    = string
  default = ""
}

variable "key_name" {
  type    = string
  default = ""
}

variable "vpc_name" {
  type    = string
  default = ""
}

variable "env" {
  type    = string
  default = ""
}

variable "target_group_arns" {
  type    = string
  default = ""
}

variable "public_key" {
  type    = string
  default = ""
}