# global
variable "environment" {
  description = "The environment we are building"
}

variable "region" {
  description = "Region that the instances will be created in"
}

variable "availability_zone" {
  description = "The AZ that the resources will be launched in"
}

# vpc
variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
}

variable "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
}

# instances
variable "key_name" {
  description = "The aws keypair to use"
}
variable "web_instance_count" {
  description = "The total count of web instances to launch"
}
variable "bastion_instance_type" {
  description = "The instance type/size to use for the bastion server"
}
variable "bastion_ami" {
  description = "The AMI to use for the bastion server"
}
variable "web_instance_type" {
  description = "The instance type/size to use for the web nodes"
}
variable "web_ami" {
  description = "The AMI to use for the web nodes"
}

# dns
variable "dns_zone_name" {
  description = "The name of the DNS zone"
}