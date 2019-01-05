# global
environment            = "staging"
dns_zone_name          = "staging.glarssonaws.local"
region                 = "eu-north-1"
availability_zones     = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]

# vpc
vpc_cidr               = "10.0.0.0/16"
public_subnet_cidrs    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs   = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
db_subnet_cidrs        = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

# instances
key_name               = "staging_key"
bastion_instance_type  = "t3.nano"
bastion_ami            = "ami-b133bccf"
web_instance_type      = "t3.nano"
web_ami                = "ami-b133bccf"
database_instance_type = "db.t3.small"

