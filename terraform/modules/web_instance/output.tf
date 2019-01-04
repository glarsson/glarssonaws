output "web_nodes_ips" {
  value = ["${aws_instance.web.*.private_ip}"]
}
output "web_nodes_id" {
  value = ["${aws_instance.web.*.id}"]
}
