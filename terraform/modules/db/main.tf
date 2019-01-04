
resource "aws_db_subnet_group" "db-subnet-group" {
  name           = "${var.environment}-db-subnet-group"
  description    = "database subnet group"
  subnet_ids     = ["${var.db_subnet_ids}"]
  tags {
    Name         = "${var.environment}-db-subnet-group"
    Environment  = "${var.environment}"
  }
}

resource "aws_rds_cluster" "aurora_cluster" {
    cluster_identifier            = "${var.environment}-aurora-cluster"
    database_name                 = "glarssonaws_db"
    master_username               = "${var.rds_master_username}"
    master_password               = "${var.rds_master_password}"
    backup_retention_period       = 1
    preferred_backup_window       = "02:00-03:00"
    preferred_maintenance_window  = "wed:03:00-wed:04:00"
    db_subnet_group_name          = "${aws_db_subnet_group.db-subnet-group.id}"
    skip_final_snapshot           = true
    vpc_security_group_ids        = ["${var.db_sg_id}"]
    tags {
        Name                      = "${var.environment}-aurora-db-cluster"
        Environment               = "${var.environment}"
    }
}

resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
    count                 = "${length(var.db_subnet_cidrs)}"
    identifier            = "${var.environment}-aurora-instance-${count.index+1}"
    cluster_identifier    = "${aws_rds_cluster.aurora_cluster.id}"
    instance_class        = "${var.database_instance_type}"
    db_subnet_group_name  = "${aws_db_subnet_group.db-subnet-group.name}"
    publicly_accessible   = false
    tags {
        Name              = "${var.environment}-aurora-db-instance-${count.index+1}"
        Environment       = "${var.environment}"
    }
}
