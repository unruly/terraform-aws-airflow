output "airflow_public_dns" {
  value = "${aws_instance.airflow_instance.public_dns}"
}

output "airflow_database_security_group_id" {
  value = "${aws_security_group.allow_airflow_database.id}"
}