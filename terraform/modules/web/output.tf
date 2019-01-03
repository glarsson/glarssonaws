output "lb_dns_name" {
  value = "${aws_elb.web.dns_name}"
}
