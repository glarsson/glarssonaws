resource "aws_elb" "web" {
  name            = "${var.environment}-web-lb"
  subnets         = ["${var.public_subnet_ids}"]
  security_groups = ["${var.web_inbound_sg_id}"]

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
  instances = ["${var.web_nodes_id}"]
  tags {
    Name        = "${var.environment}-web-lb"
    Environment = "${var.environment}"
  }
}
