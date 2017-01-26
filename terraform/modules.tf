module "aws_vpc" {
    source = "./aws_vpc"
	access_key = "${var.access_key}"
	secret_key = "${var.secret_key}"
	region = "${var.region}"
}