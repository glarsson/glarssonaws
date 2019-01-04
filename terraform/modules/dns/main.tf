resource "aws_route53_zone" "primary" {
  vpc {
    vpc_id = "${var.vpc_id}"
  }
  name     = "${var.dns_zone_name}"
}

resource "aws_route53_record" "www" {
  zone_id  = "${aws_route53_zone.primary.zone_id}"
  name     = "www.${var.dns_zone_name}"
  type     = "CNAME"
  ttl      = "300"
  records  = ["${var.web_lb_dns_name}"]
}

resource "aws_route53_record" "bastion" {
  count    = "${length(var.public_subnet_cidrs)}"
  zone_id  = "${aws_route53_zone.primary.zone_id}"
  name     = "bastion-${count.index+1}.${var.dns_zone_name}"
  type     = "CNAME"
  ttl      = "300"
  records  = ["${element(var.bastion_dns_names, count.index)}"]
}
