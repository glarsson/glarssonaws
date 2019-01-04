resource "aws_instance" "bastion" {
  count                       = "${length(var.public_subnet_cidrs)}"
  ami                         = "${var.bastion_ami}"
  instance_type               = "${var.bastion_instance_type}"
  key_name                    = "${var.key_name}"
  monitoring                  = false
  vpc_security_group_ids      = ["${var.bastion_server_sg_id}"]
  subnet_id                   = "${element(var.public_subnet_ids, count.index)}"  
  associate_public_ip_address = true
  ebs_block_device {
    device_name               = "/dev/sda1"
    delete_on_termination     = true
  }
  user_data                   = "${file("${path.module}/files/user_data.sh")}"  
  tags {
    Name                      = "${var.environment}-bastion-server-${count.index+1}"
    Environment               = "${var.environment}"
  }
}