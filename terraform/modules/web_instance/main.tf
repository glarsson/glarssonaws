resource "aws_instance" "web" {
  count                   = "${length(var.private_subnet_cidrs)}"
  ami                     = "${var.web_ami}"
  instance_type           = "${var.web_instance_type}"
  subnet_id               = "${element(var.private_subnets_id, count.index)}"
  vpc_security_group_ids  = ["${var.web_server_sg_id}"]
  
  ebs_block_device {
    device_name           = "/dev/sda1"
    delete_on_termination = true
  }

  key_name                = "${var.key_name}"
  user_data               = "${file("${path.module}/files/user_data.sh")}"
  tags = {
    Name                  = "${var.environment}-web-${count.index+1}"
    Environment           = "${var.environment}"
  }
}

