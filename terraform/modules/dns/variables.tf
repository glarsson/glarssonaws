variable "vpc_id" {}
variable "dns_zone_name" {}
variable "lb_dns_name" {}
variable "bastion_dns_names" {
  type = "list"
}
variable "public_subnet_cidrs" {
  type = "list"
}