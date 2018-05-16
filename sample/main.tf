provider "aws" {
  region = "eu-west-1"
}

variable "key_name"    { type = "string" }

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "airflow-test-vpc"
  cidr = "10.10.0.0/16"

  azs             = ["eu-west-1a",     "eu-west-1b",     "eu-west-1c"    ]
  private_subnets = ["10.10.1.0/24",   "10.10.2.0/24",   "10.10.3.0/24"  ]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
}

module "airflow" {
  source            = "unruly/airflow/aws"
  version           = "0.1.4"

  ami               = "ami-6e28b517" # CentOS 7 community image for eu-west-1

  key               = "${var.key_name}"
  db_password       = "thisistheairflowdbpassword"
  fernet_key        = "8hEdQizWjFGANL-MfypCwijKR66tb3uYNdJsrZRioaI="

  vpc_id            = "${module.vpc.vpc_id}"

  security_group_id = "${aws_security_group.airflow-security-group.id}"
  subnet_ids        = [ "${module.vpc.public_subnets[0]}", "${module.vpc.public_subnets[1]}" ]
}

resource "aws_security_group" "airflow-security-group" {
  name        = "security_group_airflow"
  description = "Traffic to Airflow instance"
  vpc_id      = "${module.vpc.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = "${aws_security_group.airflow-security-group.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web" {
  security_group_id = "${aws_security_group.airflow-security-group.id}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

output "airflow_public_dns" {
  value = "${module.airflow.airflow_instance_public_dns}"
}