provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket         = "tfstate-remote-backend-00014"
    key            = "jupiter/statefile"
    region         = "us-east-2"
    dynamodb_table = "jupiter-state-locking-00014"
    encrypt        = true
  }
}

module "vpc" {
  source             = "./vpc"
  vpc_cidr_block     = var.vpc_cidr_block
  tags               = local.project_tags
  availability_zone  = var.availability_zone
  public_cidr_block  = var.public_cidr_block
  private_cidr_block = var.private_cidr_block
  db_cidr_block      = var.db_cidr_block

}

module "ec2" {
  source                  = "./ec2"
  public_subnet_az_2a_id  = module.vpc.public_subnet_az_2a_id
  vpc_id                  = module.vpc.vpc_id
  ami_id                  = var.ami_id
  key_name                = var.key_name
  tags                    = local.project_tags
  instance_type           = var.instance_type
  private_subnet_az_2a_id = module.vpc.private_subnet_az_2a_id
  private_subnet_az_2b_id = module.vpc.private_subnet_az_2b_id
}

module "auto-scaling" {
  source                 = "./auto-scaling"
  public_subnet_az_2a_id = module.vpc.public_subnet_az_2a_id
  min_size               = var.min_size
  public_subnet_az_2b_id = module.vpc.public_subnet_az_2b_id
  jupiter_app_tg_arn     = module.alb.jupiter_app_tg_arn
  key_name               = var.key_name
  desired_capacity       = var.desired_capacity
  ami_id                 = var.ami_id
  tags                   = local.project_tags
  max_size               = var.max_size
  instance_type          = var.instance_type
  vpc_id                 = module.vpc.vpc_id

}

module "alb" {
  source                 = "./alb"
  public_subnet_az_2a_id = module.vpc.public_subnet_az_2a_id
  public_subnet_az_2b_id = module.vpc.public_subnet_az_2b_id
  vpc_id                 = module.vpc.vpc_id
  tags                   = local.project_tags
}