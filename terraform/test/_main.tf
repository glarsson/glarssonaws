provider "aws" {
  region = "${var.region}"
}

resource "aws_key_pair" "key" {
  key_name   = "${var.key_name}"
  public_key = "${file("test_key.pub")}"
}