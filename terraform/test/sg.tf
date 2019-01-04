module "sg" {
  source               = "../modules/sg"
  environment          = "${var.environment}"
  vpc_cidr_block       = "${var.vpc_cidr}"
  vpc_id               = "${module.network.vpc_id}"  
}