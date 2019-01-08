output "web_loadbalancer_public_dns_name" {
  value = "${module.web_lb.web_lb_dns_name}"
}

output "web_loadbalancer_private_dns_name" {
  value ="${module.dns.web_loadbalancer_private_dns_name}"
}

output "name_servers" {
  value = "${module.dns.name_servers}"
}

output "bastion_public_dns_names" {
  value = "${module.bastion_instance.bastion_dns_names}"
}
output "bastion_private_dns_names" {
  value = "${module.dns.bastion_private_dns_names}"
}

output "web_nodes_private_dns_names" {
  value = "${module.dns.web_nodes_private_dns_names}"
}

output "web_nodes_ips" {
  value = "${module.web_instance.web_nodes_ips}"
}

output "database_endpoint" {
  value = "${module.db_test.database_endpoint}"
}
