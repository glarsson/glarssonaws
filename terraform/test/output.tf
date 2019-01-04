output "loadbalancer_dns_name" {
  value = "${module.web.lb_dns_name}"
}

output "name_servers" {
  value = "${module.dns.name_servers}"
}

output "bastion_dns_names" {
  value = "${module.network.bastion_dns_names}"
}

output "web_nodes_dns_names" {
  value = "${module.web.web_nodes_dns_names}"
}

#output "cluster_endpoint" {
#  value = "${module.db.cluster_endpoint}"
#}