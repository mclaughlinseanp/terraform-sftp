variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "key_name" {}

variable "aws_vpc_id" {}
variable "aws_vpc_subet_one_id" {}
variable "aws_vpc_subet_two_id" {}

variable "aws_ec2_ami" {
  default = "ami-fe71759d"
}

variable "vpc_security_group_ingress_cidr_block_list" {
  type = "list"
}
variable "vpc_security_group_egress_cidr_block" {
  default = "0.0.0.0/0"
}

variable "instance_type" {
	default = "t2.micro"
}