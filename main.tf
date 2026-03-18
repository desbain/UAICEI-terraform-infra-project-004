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
  source        = "./ec2"
  subnet_id     = module.vpc.subnet_id
  vpc_id        = module.vpc.vpc_id
  ami_id        = var.ami_id
  key_name      = var.key_name
  tags          = local.project_tags
  instance_type = var.instance_type
}