resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name        = "${var.environment}-vpc"
    Environment = "${var.environment}"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.environment}-igw"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "public" {
  count                   = "${length(var.public_subnet_cidrs)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public_subnet_cidrs[count.index]}"
  availability_zone       = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = true
  tags {
    Name        = "${var.environment}-public-subnet-${count.index+1}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "private" {
  count                   = "${length(var.private_subnet_cidrs)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.private_subnet_cidrs[count.index]}"
  map_public_ip_on_launch = false
  availability_zone       = "${var.availability_zones[count.index]}"

  tags {
    Name        = "${var.environment}-private-subnet-${count.index+1}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "db" {
  count                   = "${length(var.db_subnet_cidrs)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.db_subnet_cidrs[count.index]}"
  map_public_ip_on_launch = false
  availability_zone       = "${var.availability_zones[count.index]}"

  tags {
    Name        = "${var.environment}-db-subnet-${count.index+1}"
    Environment = "${var.environment}"
  }
}

resource "aws_eip" "nat_eip" {
  count = "${length(var.public_subnet_cidrs)}"
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  count         = "${length(var.public_subnet_cidrs)}"
  allocation_id = "${element(aws_eip.nat_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
}

resource "aws_route_table" "private" {
  vpc_id           = "${aws_vpc.vpc.id}"
  count            = "${length(var.private_subnet_cidrs)}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  }
  tags {
    Name        = "${var.environment}-private-route-table"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "db" {
  vpc_id           = "${aws_vpc.vpc.id}"
  count            = "${length(var.private_subnet_cidrs)}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  }
  tags {
    Name        = "${var.environment}-db-route-table"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name        = "${var.environment}-public-route-table"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route_table_association" "db" {
  count          = "${length(var.db_subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.db.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.db.*.id, count.index)}"
}

resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }
  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "bastion" {
  vpc_id      = "${aws_vpc.vpc.id}"
  name        = "${var.environment}-bastion-sg"
  description = "Allow SSH to bastion host from anywhere"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name        = "${var.environment}-bastion-sg"
    Environment = "${var.environment}"
  }
}

resource "aws_instance" "bastion" {
  count                       = "${length(var.private_subnet_cidrs)}"
  ami                         = "${var.bastion_ami}"
  instance_type               = "${var.bastion_instance_type}"
  key_name                    = "${var.key_name}"
  monitoring                  = false
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  subnet_id                   = "${element(aws_subnet.public.*.id, count.index)}"
  associate_public_ip_address = true
  ebs_block_device {
    device_name               = "/dev/sda1"
    delete_on_termination     = true
  }
  tags {
    Name                      = "${var.environment}-bastion-server-${count.index+1}"
    Environment               = "${var.environment}"
  }
}
