# global
variable "environment" {}
variable "region" {}
variable "availability_zones" {
  type = "list"
}

# vpc
variable "vpc_cidr" {}
variable "public_subnet_cidrs" {
  type = "list"
}
variable "private_subnet_cidrs" {
  type = "list"
}
variable "db_subnet_cidrs" {
  type = "list"
}

# instances
variable "key_name" {}
variable "bastion_instance_type" {}
variable "bastion_ami" {}
variable "web_instance_type" {}
variable "web_ami" {}
variable "database_instance_type" {}

# dns
variable "dns_zone_name" {}
