variable "environment" {}
variable "db_subnet_ids" {
  type = "list"
}
variable "db_sg_id" {}
variable "db_subnet_cidrs" {
  type = "list"
}
variable "rds_master_username" {}
variable "rds_master_password" {}
variable "database_instance_type" {}

