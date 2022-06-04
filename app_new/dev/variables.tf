// Provider block variables
variable "region" {
  type    = string
  default = "us-east-1"
}

//VPC variables

variable "vpc_name" {
  type    = string
  default = "ecs_terraform_project"
}

variable "env" {
  type        = string
  description = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "11.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "11.0.1.0/24"
}

variable "public_subnet_cidr_b" {
  type    = string
  default = "11.0.2.0/24"
}

variable "private_subnet_a_cidr" {
  type    = string
  default = "11.0.10.0/24"
}

variable "private_subnet_b_cidr" {
  type    = string
  default = "11.0.20.0/24"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

//Autoscaling variables
variable "image_id" {
  type    = string
  default = "ami-0ed9277fb7eb570c9"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "terraform-key-pair"
}
