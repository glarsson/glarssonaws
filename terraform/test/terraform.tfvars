# global
environment             = "test"
dns_zone_name           = "test.glarssonaws.local"
# temporarily change region from eu-north-1 to us-east-1 because of EC2 instance limits (waiting for support to increase limits)
region                  = "us-east-1"
availability_zones      = ["us-east-1a"]

# vpc
vpc_cidr                = "10.0.0.0/16"
public_subnet_cidrs     = ["10.0.1.0/24"]
private_subnet_cidrs    = ["10.0.11.0/24"]
db_subnet_cidrs         = ["10.0.101.0/24"]

# instances
key_name                = "test_key"

# Chef Server doesn't seem to want to fly with <2GB of RAM - to verify we're switching to a larger instance for bastion (t3.small)
# later to be made into its own instance, this is only for developing automated Chef Server installation
bastion_instance_type   = "t3.nano" 
#bastion_instance_type   = "t3.small" 

# temporarily change ami from "ami-b133bccf" in eu-north-1 to same but in us-east-1: "ami-9887c6e7"
bastion_ami             = "ami-9887c6e7"
web_instance_type       = "t3.nano"
web_ami                 = "ami-9887c6e7"
# testing to see if db.t3.micro is available in eu-north-1, otherwise revent back to "db.t3.small"
database_instance_type  = "db.t3.micro"
