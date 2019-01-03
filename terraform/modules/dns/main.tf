resource "aws_route53_zone" "primary" {
  vpc {
    vpc_id = "${var.vpc_id}"
  }
  name   = "${var.dns_zone_name}"
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name = "www.${var.dns_zone_name}"
  type = "CNAME"
  ttl = "300"
  records = ["${var.lb_dns_name}"]
}

resource "aws_route53_record" "bastion" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name = "bastion.${var.dns_zone_name}"
  type = "CNAME"
  ttl = "300"
  records = ["${var.bastion_dns_name}"]
}