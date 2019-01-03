resource "aws_security_group" "web_server_sg" {
  name        = "${var.environment}-web-server-sg"
  description = "Security group for web nodes to allow the local network to access ssh and http"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
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
    Name        = "${var.environment}-web-server-sg"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "web_inbound_sg" {
  name          = "${var.environment}-web-inbound-sg"
  description   = "Allow HTTP from Anywhere"
  vpc_id        = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}-web-inbound-sg"
    Environment = "${var.environment}"
  }
}

resource "aws_instance" "web" {
  count             = "${length(var.private_subnet_cidrs)}"
  ami               = "${var.web_ami}"
  instance_type     = "${var.web_instance_type}"
  subnet_id         = "${element(var.private_subnets_id, count.index)}"
  vpc_security_group_ids = [
    "${aws_security_group.web_server_sg.id}"
  ]
  
  ebs_block_device {
    device_name = "/dev/sda1"
    delete_on_termination = true
  }

  key_name        = "${var.key_name}"
  user_data       = "${file("${path.module}/files/user_data.sh")}"
  tags = {
    Name          = "${var.environment}-web-${count.index+1}"
    Environment   = "${var.environment}"
  }
}

resource "aws_elb" "web" {
  name            = "${var.environment}-web-lb"
  subnets         = ["${var.public_subnets_id}"]
  security_groups = ["${aws_security_group.web_inbound_sg.id}"]
  /* look into configuring a certificate, in the mean time skip https
  listener = [{
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  },{
    instance_port = 443
    instance_protocol = "https"
    lb_port = 443
    lb_protocol = "https"
  }] */
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  instances = ["${aws_instance.web.*.id}"]
  tags {
    Environment = "${var.environment}"
  }
}