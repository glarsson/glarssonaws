# global
environment             = "staging"
region                  = "eu-north-1"
availability_zones      = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]

# vpc
vpc_cidr                = "10.0.0.0/16"
public_subnet_cidrs    = ["10.0.1.0/24", "10.0.10.0/24", "10.0.100.0/24"]
private_subnet_cidrs   = ["10.0.2.0/24", "10.0.20.0/24", "10.0.200.0/24"]

# instances
key_name                = "staging_key"
web_instance_count      = 2
bastion_instance_type   = "t3.nano"
bastion_ami             = "ami-b133bccf"
web_instance_type       = "t3.nano"
web_ami                 = "ami-b133bccf"

# dns
dns_zone_name           = "staging.glarssonaws.local"