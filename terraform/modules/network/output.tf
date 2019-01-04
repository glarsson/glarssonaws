output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "public_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}
output "private_subnets_id" {
  value = ["${aws_subnet.private.*.id}"]
}
output "db_subnet_ids" {
  value = ["${aws_subnet.db.*.id}"]
}
output "bastion_subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}