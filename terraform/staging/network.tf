module "network" {
  source                = "../modules/network"
  environment           = "${var.environment}"
  vpc_cidr              = "${var.vpc_cidr}"
  public_subnet_cidr    = "${var.public_subnet_cidr}"
  private_subnet_cidr   = "${var.private_subnet_cidr}"
  availability_zone     = "${var.availability_zone}"
  key_name              = "${var.key_name}"
  bastion_ami           = "${var.bastion_ami}"
  bastion_instance_type = "${var.bastion_instance_type}"
}