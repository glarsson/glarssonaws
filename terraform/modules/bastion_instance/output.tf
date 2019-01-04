output "bastion_dns_names" {
  value = ["${aws_instance.bastion.*.public_dns}"]
}