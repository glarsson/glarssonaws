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
variable "environment" {}
variable "availability_zones" {
  type = "list"
}
variable "db_availability_zones" {
  type = "list"
}