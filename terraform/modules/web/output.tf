output "lb_dns_name" {
  value = "${aws_elb.web.dns_name}"
}
output "web_nodes_dns_names" {
  value = ["${aws_instance.web.*.private_dns}"]
}