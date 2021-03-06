# global
environment             = "test"
dns_zone_name           = "test.glarssonaws.local"
# temporarily change region from eu-north-1 to us-east-1 because of EC2 instance limits (waiting for support to increase limits)
region                  = "us-east-1"
availability_zones      = ["us-east-1a"]

# hack because db subnet group seems to require at least two availability zones and I don't want to bring
# up extra machines for no reason in test
db_availability_zones      = ["us-east-1a", "us-east-1b"]


# vpc
vpc_cidr                = "10.0.0.0/16"
public_subnet_cidrs     = ["10.0.1.0/24"]
private_subnet_cidrs    = ["10.0.11.0/24"]
db_subnet_cidrs         = ["10.0.101.0/24","10.0.102.0/24"]

# instances
key_name                = "test_key"

# temporarily change ami from "ami-b133bccf" in eu-north-1 to same but in us-east-1: "ami-9887c6e7"

# temp using t3.small for troubleshooting
#bastion_instance_type   = "t3.nano"
bastion_ami             = "ami-9887c6e7"
bastion_instance_type   = "t2.nano" 

# temporarily using "t3.micro" instead of "t3.nano" because of the bigger RAM, dotnet core doesn't seem to
# like tight spaces... going to cost a fortune :P

web_instance_type       = "t2.micro"
web_ami                 = "ami-9887c6e7"

# db.t3.micro might need to be used in eu-north-1
database_instance_type  = "db.t2.micro"
