output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_az_2a_id"{
  value = aws_subnet.public_subnet_az_2a.id
}

output "private_subnet_az_2a_id" {
  value = aws_subnet.private_subnet_az_2a.id
}

output "private_subnet_az_2b_id" {
  value = aws_subnet.private_subnet_az_2b.id
}
