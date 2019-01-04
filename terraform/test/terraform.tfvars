# global
environment             = "test"
region                  = "eu-north-1"
availability_zones      = ["eu-north-1a"]

# vpc
vpc_cidr                = "10.0.0.0/16"
public_subnet_cidrs    = ["10.0.1.0/24"]
private_subnet_cidrs   = ["10.0.11.0/24"]
db_subnet_cidrs        = ["10.0.101.0/24"]

# instances
key_name                = "test_key"
bastion_instance_type   = "t3.nano"
bastion_ami             = "ami-b133bccf"
web_instance_type       = "t3.nano"
web_ami                 = "ami-b133bccf"
database_instance_type  = "db.t3.small"

# dns
dns_zone_name           = "test.glarssonaws.local"