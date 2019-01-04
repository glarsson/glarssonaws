output "bastion_server_sg_id" {
  value = "${aws_security_group.bastion_server_sg.id}"  
}
output "web_server_sg_id" {
  value = "${aws_security_group.web_server_sg.id}"  
}

output "db_sg_id" {
  value = "${aws_security_group.db_sg.id}"  
}

output "web_inbound_sg_id" {
  value = "${aws_security_group.web_inbound_sg.id}"  
}
output "default_sg_id" {
  value = "${aws_security_group.default.id}"
}