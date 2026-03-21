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

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "ssl_policy" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "name" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "db_name" {
  type = string
}

variable "engine" {
  type = string
}

variable  "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "parameter_group_name"{
  type = string
}

variable "region" {
  type = string
}

variable "account_id" {
  type = string
}
