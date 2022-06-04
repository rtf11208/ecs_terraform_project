provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "ecs-terraform-project"
    key    = "state.tfstate"
    region = "us-east-1"
  }
}

module "vpc" {
  source                = "../../modules/vpc"
  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  public_subnet_cidr_b  = var.public_subnet_cidr_b
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
  availability_zones    = var.availability_zones
}

module "security" {
  source = "../../modules/security"
  vpc_id = module.vpc.vpc_id
}

module "autoscaling" {
  source               = "../../modules/autoscaling"
  image_id             = var.image_id
  instance_type        = var.instance_type
  ecs_security_group   = module.security.ecs_security_group
  bastion_host_sg      = module.security.bastion_host_sg
  iam_instance_profile = module.iam.iam_ecs_instance_profile
  public_subnet_id     = module.vpc.public_subnet
  private_subnet_id_a  = module.vpc.private_subnet_id_a
  private_subnet_id_b  = module.vpc.private_subnet_id_b
  vpc_name             = var.vpc_name
  env                  = var.env
}

module "iam" {
  source = "../../modules/iam"
}

module "load_balancer" {
  source              = "../../modules/load_balancer"
  vpc_id              = module.vpc.vpc_id
  target_id           = module.ecs.target_id
  private_subnet_id_a = module.vpc.private_subnet_id_a
  private_subnet_id_b = module.vpc.private_subnet_id_b
  ecs_security_group  = module.security.ecs_security_group
}

module "ecs" {
  source           = "../../modules/ecs"
  target_group_arn = module.load_balancer.target_group_arn
}