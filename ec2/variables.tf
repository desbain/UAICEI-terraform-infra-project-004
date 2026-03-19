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

variable "public_subnet_az_2a_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "private_subnet_az_2a_id" {
  type = string
}

variable "private_subnet_az_2b_id" {
  type = string
} 
