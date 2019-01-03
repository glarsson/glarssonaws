module "web" {
  source              = "../modules/web"
  web_instance_count  = "${var.web_instance_count}"
  web_instance_type   = "${var.web_instance_type}"
  web_ami             = "${var.web_ami}"
  private_subnet_id   = "${module.network.private_subnet_id}"
  public_subnet_id    = "${module.network.public_subnet_id}"
  key_name            = "${var.key_name}"
  environment         = "${var.environment}"
  vpc_id              = "${module.network.vpc_id}"
  vpc_cidr_block      = "${var.vpc_cidr}"
}