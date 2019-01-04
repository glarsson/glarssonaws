output "web_loadbalancer_dns_name" {
  value = "${module.web_lb.web_lb_dns_name}"
}

output "name_servers" {
  value = "${module.dns.name_servers}"
}

output "bastion_dns_names" {
  value = "${module.bastion_instance.bastion_dns_names}"
}

output "web_nodes_ips" {
  value = "${module.web_instance.web_nodes_ips}"
}

output "cluster_endpoint" {
  value = "${module.db.cluster_endpoint}"
}