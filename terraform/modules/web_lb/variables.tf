variable "environment" {}

variable "web_inbound_sg_id" {}

variable "public_subnet_ids" {
  type = "list"
}
variable "web_nodes_id" {
  type ="list"
}
