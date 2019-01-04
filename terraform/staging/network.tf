module "network" {
  source                = "../modules/network"
  environment           = "${var.environment}"
  vpc_cidr              = "${var.vpc_cidr}"
  public_subnet_cidrs   = "${var.public_subnet_cidrs}"
  private_subnet_cidrs  = "${var.private_subnet_cidrs}"
  db_subnet_cidrs       = "${var.db_subnet_cidrs}"
  availability_zones    = "${var.availability_zones}"
  key_name              = "${var.key_name}"
  bastion_ami           = "${var.bastion_ami}"
  bastion_instance_type = "${var.bastion_instance_type}"
}