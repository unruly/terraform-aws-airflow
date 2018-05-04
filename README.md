# terraform-aws-airflow

Terraform module to deploy an [Apache Airflow](https://airflow.apache.org/) instance on [AWS](https://aws.amazon.com/) backed by an RDS PostgreSQL database for storage.

![Vault architecture](https://github.com/unruly/terraform-aws-airflow/blob/master/_docs/architecture.png?raw=true)

## How to use this Module

```terraform
module "example-airflow-setup" {
  source            = "unruly/terraform-aws-airflow"
  key               = "your-aws-keypair"
  db_password       = "some-db-password"
  fernet_key        = "your-fernet-key"
  vpc_id            = "some-vpc-id"
  security_group_id = "some-security-group-id"
  subnet_ids        = [ "id-1", "id-2" ]
}
```
## Configuration

Argument | Description
--- | ---
ami | AMI code for the Airflow server (default: ami-a042f4d8 - CentOS 7 community image)
instance_type | Instance type for the Airflow server (default: c3.xlarge)
key | AWS SSH Key Pair name
subnet_ids | List of AWS subnet ids for Airflow server and database
vpc_id | AWS VPC in which to create the Airflow server
security_group_id | AWS Security group in which to create the Airflow server
db_password | Password for the PostgreSQL instance
fernet_key | Key for encrypting data in the database - see [Airflow docs](https://airflow.apache.org/configuration.html?highlight=fernet#connections)
