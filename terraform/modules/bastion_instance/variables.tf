variable "environment" {}
variable "public_subnet_cidrs" {
  type = "list"
}
variable "public_subnet_ids" {
  type = "list"
}
variable "key_name" {}
variable "bastion_instance_type" {}
variable "bastion_ami" {}
variable "bastion_server_sg_id" {}

