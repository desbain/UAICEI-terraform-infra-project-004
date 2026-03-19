variable "vpc_id" {
  type = string
}

variable "tags" {
  type = map(string)
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

variable "public_subnet_az_2a_id" {
  type = string
}

variable "public_subnet_az_2b_id" {
  type = string
}

variable "jupiter_app_tg_arn" {
  type = list(string)
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