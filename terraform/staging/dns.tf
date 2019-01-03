module "dns" {
  source            = "../modules/dns"
  bastion_dns_name  = "${module.network.bastion_dns_name}"
  dns_zone_name     = "${var.dns_zone_name}"
  vpc_id            = "${module.network.vpc_id}"
  lb_dns_name       = "${module.web.lb_dns_name}"
}
