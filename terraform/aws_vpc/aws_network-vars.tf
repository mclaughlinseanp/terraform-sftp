variable "access_key" {}
variable "secret_key" {}
variable "region" {}

variable "vpc_cidr_block" {
  default = "10.0.0.0/24"
}
variable "vpc_subnet1_cidr_block" {
  default = "10.0.0.0/25"
}
variable "vpc_subnet1_availability_zone" {
  default = "ap-southeast-2a"
}
variable "vpc_subnet2_cidr_block" {
  default = "10.0.0.128/25"
}
variable "vpc_subnet2_availability_zone" {
  default = "ap-southeast-2b"
}
variable "vpc_route_table_cidr_block" {
  default = "0.0.0.0/0"
}