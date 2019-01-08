# global
environment            = "staging"
dns_zone_name          = "staging.glarssonaws.local"
region                 = "us-east-1"
availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]



# vpc
vpc_cidr               = "10.0.0.0/16"
public_subnet_cidrs    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs   = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
db_subnet_cidrs        = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

# instances
# AMIs: eu-north-1: "ami-b133bccf". us-east-1: "ami-9887c6e7"
# TYPE (bastion) : eu-north-1: "t3.nano". us-east-1: "t2.nano"
# TYPE (web node): eu-north-1: "t3.micro". us-east-1: "t2.micro"
# TYPE (database): eu-north-1: "db.t3.small". us-east-1: "db.t2.small"


key_name               = "staging_key"
bastion_instance_type  = "t2.nano"
bastion_ami            = "ami-9887c6e7"
web_instance_type      = "t2.micro"
web_ami                = "ami-9887c6e7"
database_instance_type = "db.t2.small"

