variable "region" {
  default = "us-west-2"
}

variable "ami" {
  type    = "string"
  default = "ami-a042f4d8" # CentOS 7 community image
}

variable "instance_type" {
  type    = "string"
  default = "c3.xlarge"
}

variable "key" {
  type = "string"
}

variable "subnet_ids" {
  type = "list"
}

variable "security_group_id" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "db_password" {
  type = "string"
}

variable "fernet_key" {
  type = "string"
}
