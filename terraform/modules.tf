module "aws_vpc" {
    source = "./aws_vpc"
	access_key = "${var.access_key}"
	secret_key = "${var.secret_key}"
	region = "${var.region}"
}

module "aws_ec2" {
    source = "./aws_ec2"
	access_key = "${var.access_key}"
	secret_key = "${var.secret_key}"
	region = "${var.region}"
	key_name = "${var.key_name}"
	aws_vpc_id = "${module.aws_vpc.aws_vpc_id}"
	aws_vpc_subet_one_id  = "${module.aws_vpc.subet_one_id}"
	aws_vpc_subet_two_id  = "${module.aws_vpc.subet_two_id}"
	vpc_security_group_ingress_cidr_block_list = [ "${var.vpc_security_group_ingress_cidr_block_list}" ]
}