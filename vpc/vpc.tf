resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-main-vpc"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-igw"
  })
}

# CREATING PUBLIC SUBNETS
resource "aws_subnet" "public_subnet_az_2a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.public_cidr_block[0]
  availability_zone = var.availability_zone[0]

 tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-subnet-az-2a"
  })
}

  # CREATING PUBLIC SUBNETS
resource "aws_subnet" "public_subnet_az_2b" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.public_cidr_block[1]
  availability_zone = var.availability_zone[1]

 tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-subnet-az-2b"
  })
}

#CREATING PRIVATE SUBNET -------------------------------------------------------------------------------
resource "aws_subnet" "private_subnet_az_2a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_cidr_block[0]
  availability_zone = var.availability_zone[0]

 tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-subnet-az-2b"
  })
}

  resource "aws_subnet" "private_subnet_az_2b" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_cidr_block[1]
  availability_zone = var.availability_zone[1]

 tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-subnet-az-2b"
  })
  }

#CREATING DATABASE SUBNET------------------------------------------------------------------------------------------
  resource "aws_subnet" "db_subnet_az_2a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.db_cidr_block[0]
  availability_zone = var.availability_zone[0]
 tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-db-subnet-az-2a"
  })
  }

  resource "aws_subnet" "db_subnet_az_2b" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.db_cidr_block[1]
  availability_zone = var.availability_zone[1]
 tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-db-subnet-az-2b"
  })
  }
