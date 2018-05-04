variable "ami" {
  type        = "string"
  default     = "ami-a042f4d8" # CentOS 7 community image
  description = "AMI code for the Airflow server"
}

variable "instance_type" {
  type        = "string"
  default     = "c3.xlarge"
  description = "Instance type for the Airflow server"
}

variable "key" {
  type        = "string"
  description = "AWS SSH Key Pair name"
}

variable "subnet_ids" {
  type        = "list"
  description = "List of AWS subnet ids for Airflow server and database"
}

variable "vpc_id" {
  type        = "string"
  description = "AWS VPC in which to create the Airflow server"
}

variable "security_group_id" {
  type        = "string"
  description = "AWS Security group in which to create the Airflow server"
}

variable "db_password" {
  type        = "string"
  description = "Password for the PostgreSQL instance"
}

variable "fernet_key" {
  type        = "string"
  description = "Key for encrypting data in the database - see Airflow docs"
}
