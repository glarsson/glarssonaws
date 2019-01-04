module "web" {
  source               = "../modules/web"
  web_instance_type    = "${var.web_instance_type}"
  web_ami              = "${var.web_ami}"
  private_subnets_id   = "${module.network.private_subnets_id}"
  private_subnet_cidrs = "${var.private_subnet_cidrs}"
  public_subnets_id    = "${module.network.public_subnets_id}"
  key_name             = "${var.key_name}"
  environment          = "${var.environment}"
  vpc_id               = "${module.network.vpc_id}"
  vpc_cidr_block       = "${var.vpc_cidr}"
  web_server_sg_id     = "${module.sg.web_server_sg_id}"
  web_inbound_sg_id    = "${module.sg.web_inbound_sg_id}"
}