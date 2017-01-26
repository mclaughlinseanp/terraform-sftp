#shared
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "ap-southeast-2"
}

#aws_ec2
variable "key_name" {}
variable "vpc_security_group_ingress_cidr_block_list" {
  type = "list"
}