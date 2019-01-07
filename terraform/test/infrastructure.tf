provider "aws" {
  region                 = "${var.region}"
}
resource "aws_key_pair" "key" {
  key_name               = "${var.key_name}"
  public_key             = "${file("keys/test_key.pub")}"
}
module "network" {
  source                 = "../modules/network"
  environment            = "${var.environment}"
  vpc_cidr               = "${var.vpc_cidr}"
  public_subnet_cidrs    = "${var.public_subnet_cidrs}"
  private_subnet_cidrs   = "${var.private_subnet_cidrs}"
  db_subnet_cidrs        = "${var.db_subnet_cidrs}"
  availability_zones     = "${var.availability_zones}"
  db_availability_zones  = "${var.db_availability_zones}"
  
}
module "sg" {
  source                 = "../modules/sg"
  environment            = "${var.environment}"
  vpc_cidr_block         = "${var.vpc_cidr}"
  vpc_id                 = "${module.network.vpc_id}"  
}
module "bastion_instance" {
  source                 = "../modules/bastion_instance"
  bastion_instance_type  = "${var.bastion_instance_type}"
  bastion_ami            = "${var.bastion_ami}"
  public_subnet_cidrs    = "${var.public_subnet_cidrs}"
  key_name               = "${var.key_name}"
  environment            = "${var.environment}"
  bastion_server_sg_id   = "${module.sg.bastion_server_sg_id}"
  public_subnet_ids      = "${module.network.public_subnet_ids}"
}
module "web_instance" {
  source                 = "../modules/web_instance"
  web_instance_type      = "${var.web_instance_type}"
  web_ami                = "${var.web_ami}"
  private_subnets_id     = "${module.network.private_subnets_id}"
  private_subnet_cidrs   = "${var.private_subnet_cidrs}"
  public_subnet_ids      = "${module.network.public_subnet_ids}"
  key_name               = "${var.key_name}"
  environment            = "${var.environment}"
  vpc_id                 = "${module.network.vpc_id}"
  vpc_cidr_block         = "${var.vpc_cidr}"
  web_server_sg_id       = "${module.sg.web_server_sg_id}"
  web_inbound_sg_id      = "${module.sg.web_inbound_sg_id}"
database_endpoint        = "${module.db_test.database_endpoint}"
  rds_master_password    = "${var.rds_master_password}" 
}
module "web_lb" {
  source                 = "../modules/web_lb"
  web_inbound_sg_id      = "${module.sg.web_inbound_sg_id}"
  environment            = "${var.environment}"
  public_subnet_ids      = "${module.network.public_subnet_ids}"
  web_nodes_id           = "${module.web_instance.web_nodes_id}"
}
module "dns" {
  source                 = "../modules/dns"
  bastion_dns_names      = "${module.bastion_instance.bastion_dns_names}"
  dns_zone_name          = "${var.dns_zone_name}"
  vpc_id                 = "${module.network.vpc_id}"
  web_lb_dns_name        = "${module.web_lb.web_lb_dns_name}"
  public_subnet_cidrs    = "${var.public_subnet_cidrs}"
  database_endpoint      = "${module.db_test.database_endpoint}"
}

module "db_test" {
  source                 = "../modules/db_test"
  db_subnet_ids          = "${module.network.db_subnet_ids}"
  db_subnet_cidrs        = "${var.db_subnet_cidrs}"
  environment            = "${var.environment}"
  rds_master_username    = "${var.rds_master_username}"
  rds_master_password    = "${var.rds_master_password}"
  db_sg_id               = "${module.sg.db_sg_id}"
  database_instance_type = "${var.database_instance_type}"
}
