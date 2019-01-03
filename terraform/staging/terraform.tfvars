# global
environment             = "staging"
region                  = "eu-north-1"
availability_zone       = "eu-north-1a"

# vpc
vpc_cidr                = "10.0.0.0/16"
public_subnet_cidr      = "10.0.1.0/24"
private_subnet_cidr     = "10.0.2.0/24"

# instances
key_name                = "staging_key"
web_instance_count      = 2
bastion_instance_type   = "t3.nano"
bastion_ami             = "ami-b133bccf"
web_instance_type       = "t3.nano"
web_ami                 = "ami-b133bccf"

# dns
dns_zone_name       = "staging.glarssonaws.local"