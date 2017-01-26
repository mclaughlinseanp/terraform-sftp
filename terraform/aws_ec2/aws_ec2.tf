provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# EC2 IAM Setup

resource "aws_iam_role" "terraformSftpDemoRole" {
  name = "terraformSftpDemoRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "terraformSftpDemoInstanceProfile" {
  name  = "terraformSftpDemoInstanceProfile"
  roles = ["${aws_iam_role.terraformSftpDemoRole.name}"]
}


#EC2 Server Setup

resource "aws_security_group" "terraformSftpConsulDemoInstanceSecurityGroup" {
  name = "terraformSftpConsulDemoInstanceSecurityGroup"
  description = "Group for SFTP Server - inbound connections on port 22 only for configured addresses"

  vpc_id = "${var.aws_vpc_id}"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "6"
      cidr_blocks = ["${var.vpc_security_group_ingress_cidr_block_list}"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["${var.vpc_security_group_egress_cidr_block}"]
  }
  
  tags {
    Name = "terraformSftpConsulDemoInstanceSecurityGroup"
  }
}

resource "aws_instance" "terraformSftpServer" {
    key_name            	= "${var.key_name}"
	ami 					= "${var.aws_ec2_ami}"
    instance_type 			= "${var.instance_type}"
	subnet_id  				= "${var.aws_vpc_subet_one_id}"
	iam_instance_profile	= "${aws_iam_instance_profile.terraformSftpDemoInstanceProfile.id}"
	security_groups = [
      "${aws_security_group.terraformSftpConsulDemoInstanceSecurityGroup.id}",
    ]
    tags {
      Name = "Terraform SFTP Server"
    }
}

# IAM Setup

resource "aws_iam_role" "terraformSftpDemoServiceRole" {
  name = "terraformSftpDemoServiceRole"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "terraformSftpDemoServiceRolePolicy" {
  name = "terraformSftpDemoServiceRolePolicy"
  role = "${aws_iam_role.terraformSftpDemoServiceRole.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
		"ec2:AuthorizeSecurityGroupIngress"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
