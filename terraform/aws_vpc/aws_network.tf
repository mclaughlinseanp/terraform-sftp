provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_vpc" "demoVPC" {
  cidr_block = "${var.vpc_cidr_block}"
  tags {
    Name = "demoVPC"
  }
}

resource "aws_internet_gateway" "demoIG" {
  vpc_id = "${aws_vpc.demoVPC.id}"
  tags {
    Name = "demoIG"
  }
}

resource "aws_subnet" "demoSubnet0-0" {
  vpc_id = "${aws_vpc.demoVPC.id}"
  cidr_block = "${var.vpc_subnet1_cidr_block}"
  availability_zone = "${var.vpc_subnet1_availability_zone}"
  tags {
    Name = "demoSubnet0-0"
  }
}

resource "aws_subnet" "demoSubnet0-1" {
  vpc_id = "${aws_vpc.demoVPC.id}"
  cidr_block = "${var.vpc_subnet2_cidr_block}"
  availability_zone = "${var.vpc_subnet2_availability_zone}"
  tags {
    Name = "demoSubnet0-1"
  }
}

resource "aws_route_table" "demoSubnet0-0RT" {
  vpc_id = "${aws_vpc.demoVPC.id}"
  route {
    cidr_block = "${var.vpc_route_table_cidr_block}"
    gateway_id = "${aws_internet_gateway.demoIG.id}"
  }
  tags {
    Name = "demoSubnet0-0RT"
  }
}

resource "aws_route_table_association" "demoSubnet0-0RTAssn" {
  subnet_id = "${aws_subnet.demoSubnet0-0.id}"
  route_table_id = "${aws_route_table.demoSubnet0-0RT.id}"
}

resource "aws_route_table_association" "demoSubnet0-1RTAssn" {
  subnet_id = "${aws_subnet.demoSubnet0-1.id}"
  route_table_id = "${aws_route_table.demoSubnet0-0RT.id}"
}

output "aws_vpc_id" {
  value = "${aws_vpc.demoVPC.id}"
}

output "subet_one_id" {
	value = "${aws_subnet.demoSubnet0-0.id}"
}

output "subet_two_id" {
	value = "${aws_subnet.demoSubnet0-1.id}"
}
