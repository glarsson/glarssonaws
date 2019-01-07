output "database_endpoint" {
    value = "${aws_db_instance.db-instance.address}"
}
