output "db_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "Endpoint de connexion à la base de données"
}

output "db_instance_id" {
  value = aws_db_instance.main.id
}
