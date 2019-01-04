module "db" {
  source                 = "../modules/db"
  db_subnets_id          = "${module.network.db_subnets_id}"
  db_subnet_cidrs        = "${var.db_subnet_cidrs}"
  environment            = "${var.environment}"
  rds_master_username    = "${var.rds_master_username}"
  rds_master_password    = "${var.rds_master_password}"
  db_sg_id               = "${module.sg.db_sg_id}"
  database_instance_type = "${var.database_instance_type}"
}