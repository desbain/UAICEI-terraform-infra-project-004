vpc_cidr_block     = "10.0.0.0/16"
public_cidr_block  = ["10.0.0.0/24", "10.0.1.0/24"]
private_cidr_block = ["10.0.2.0/24", "10.0.3.0/24"]
db_cidr_block      = ["10.0.4.0/24", "10.0.5.0/24"]
availability_zone  = ["us-east-2a", "us-east-2b"]
 ami_id               = "ami-0b0b78dcacbab728f"
 instance_type     = "t2.micro"
 key_name          = "jupiter360keys"