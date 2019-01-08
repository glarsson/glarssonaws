output "name_servers" {  
  value = "${aws_route53_zone.private.name_servers}"
}
output "web_nodes_private_dns_names" {
  value ="${aws_route53_record.web.*.fqdn}"
}
output "bastion_private_dns_names" {
  value ="${aws_route53_record.bastion.*.fqdn}"
}
output "web_loadbalancer_private_dns_name" {
  value ="${aws_route53_record.www.fqdn}"
}