variable "web_ami" {}
variable "web_instance_type" {}
variable "public_subnet_ids" {
  type = "list"
}
variable "private_subnets_id" {
  type = "list"
}
variable "private_subnet_cidrs" {
  type = "list"
}
variable "vpc_cidr_block" {}
variable "key_name" {}
variable "environment" {}
variable "vpc_id" {}
variable "web_server_sg_id" {}
variable "web_inbound_sg_id" {}