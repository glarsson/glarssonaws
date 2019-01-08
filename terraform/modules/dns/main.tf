resource "aws_route53_zone" "private" {
  vpc {
    vpc_id = "${var.vpc_id}"
  }
  name     = "${var.dns_zone_name}"
}

resource "aws_route53_record" "www" {
  zone_id  = "${aws_route53_zone.private.zone_id}"
  name     = "www.${var.dns_zone_name}"
  type     = "CNAME"
  ttl      = "300"
  records  = ["${var.web_lb_dns_name}"]
}

resource "aws_route53_record" "database-endpoint" {
  zone_id  = "${aws_route53_zone.private.zone_id}"
  name     = "database-endpoint.${var.dns_zone_name}"
  type     = "CNAME"
  ttl      = "300"
  records  = ["${var.database_endpoint}"]
}

resource "aws_route53_record" "bastion" {
  count    = "${length(var.public_subnet_cidrs)}"
  zone_id  = "${aws_route53_zone.private.zone_id}"
  name     = "bastion-${count.index+1}.${var.dns_zone_name}"
  type     = "CNAME"
  ttl      = "300"
  records  = ["${element(var.bastion_dns_names, count.index)}"]
}

resource "aws_route53_record" "web" {
  count    = "${length(var.private_subnet_cidrs)}"
  zone_id  = "${aws_route53_zone.private.zone_id}"
  name     = "web-${count.index+1}.${var.dns_zone_name}"
  type     = "A"
  ttl      = "300"
  records  = ["${element(var.web_nodes_ips, count.index)}"]
}
