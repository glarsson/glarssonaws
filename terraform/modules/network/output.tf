output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "public_subnets_id" {
  value = ["${aws_subnet.public.*.id}"]
}
output "private_subnets_id" {
  value = ["${aws_subnet.private.*.id}"]
}
output "default_sg_id" {
  value = "${aws_security_group.default.id}"
}
output "bastion_dns_names" {
  value = ["${aws_instance.bastion.*.public_dns}"]
          
}