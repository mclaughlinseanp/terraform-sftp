provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_vpc" "terraformSftpDemoVPC" {
  cidr_block = "${var.vpc_cidr_block}"
  tags {
    Name = "terraformSftpDemoVPC"
  }
}

resource "aws_internet_gateway" "terraformSftpDemoIG" {
  vpc_id = "${aws_vpc.terraformSftpDemoVPC.id}"
  tags {
    Name = "terraformSftpDemoIG"
  }
}

resource "aws_subnet" "terraformSftpDemoSubnet0-0" {
  vpc_id = "${aws_vpc.terraformSftpDemoVPC.id}"
  cidr_block = "${var.vpc_subnet1_cidr_block}"
  availability_zone = "${var.vpc_subnet1_availability_zone}"
  tags {
    Name = "terraformSftpDemoSubnet0-0"
  }
}

resource "aws_subnet" "terraformSftpDemoSubnet0-1" {
  vpc_id = "${aws_vpc.terraformSftpDemoVPC.id}"
  cidr_block = "${var.vpc_subnet2_cidr_block}"
  availability_zone = "${var.vpc_subnet2_availability_zone}"
  tags {
    Name = "terraformSftpDemoSubnet0-1"
  }
}

resource "aws_route_table" "terraformSftpDemoSubnet0-0RT" {
  vpc_id = "${aws_vpc.terraformSftpDemoVPC.id}"
  route {
    cidr_block = "${var.vpc_route_table_cidr_block}"
    gateway_id = "${aws_internet_gateway.terraformSftpDemoIG.id}"
  }
  tags {
    Name = "terraformSftpDemoSubnet0-0RT"
  }
}

resource "aws_route_table_association" "terraformSftpDemoSubnet0-0RTAssn" {
  subnet_id = "${aws_subnet.terraformSftpDemoSubnet0-0.id}"
  route_table_id = "${aws_route_table.terraformSftpDemoSubnet0-0RT.id}"
}

resource "aws_route_table_association" "terraformSftpDemoSubnet0-1RTAssn" {
  subnet_id = "${aws_subnet.terraformSftpDemoSubnet0-1.id}"
  route_table_id = "${aws_route_table.terraformSftpDemoSubnet0-0RT.id}"
}

output "aws_vpc_id" {
  value = "${aws_vpc.terraformSftpDemoVPC.id}"
}

output "subet_one_id" {
	value = "${aws_subnet.terraformSftpDemoSubnet0-0.id}"
}

output "subet_two_id" {
	value = "${aws_subnet.terraformSftpDemoSubnet0-1.id}"
}
