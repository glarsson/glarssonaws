variable "web_instance_count" {}
variable "web_ami" {}
variable "web_instance_type" {}
variable "private_subnets_id" {
  type = "list"
}
variable "private_subnet_cidrs" {
  type = "list"
}
variable "public_subnets_id" {
  type = "list"
}
variable "vpc_cidr_block" {}
variable "key_name" {}
variable "environment" {}
variable "vpc_id" {}