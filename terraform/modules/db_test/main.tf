resource "aws_db_subnet_group" "db-subnet-group" {
  name           = "${var.environment}-db-subnet-group"
  description    = "database subnet group"
  subnet_ids     = ["${var.db_subnet_ids}"]
  tags {
    Name         = "${var.environment}-db-subnet-group"
    Environment  = "${var.environment}"
  }
}

resource "aws_db_instance" "db-instance" {
  identifier                = "${var.environment}-db-instance-${count.index+1}"
  allocated_storage         = 5
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "${var.database_instance_type}"
  name                      = "glarssonaws_db"
  username                  = "${var.rds_master_username}"
  password                  = "${var.rds_master_password}"
  db_subnet_group_name      = "${aws_db_subnet_group.db-subnet-group.name}"
  vpc_security_group_ids    = ["${var.db_sg_id}"]
  skip_final_snapshot       = true
  final_snapshot_identifier = "Ignore"
}