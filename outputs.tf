output "airflow_instance_public_dns" {
  value       = "${aws_instance.airflow_instance.public_dns}"
  description = "Public DNS for the Airflow instance"
}

output "airflow_instance_public_ip" {
  value       = "${aws_instance.airflow_instance.public_ip}"
  description = "Public IP address for the Airflow instance"
}

output "airflow_instance_private_ip" {
  value       = "${aws_instance.airflow_instance.private_ip}"
  description = "Private IP for the Airflow instance"
}

output "airflow_database_security_group_id" {
  value       = "${aws_security_group.allow_airflow_database.id}"
  description = "Security group id for the Airflow database"
}