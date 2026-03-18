variable "vpc_cidr_block" {
  type = string
}

variable "public_cidr_block" {
  type = list(string)
}

variable "private_cidr_block" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}

variable "db_cidr_block" {
  type = list(string)
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}