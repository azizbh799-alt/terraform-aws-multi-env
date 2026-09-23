output "state_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "Nom du bucket S3 à réutiliser dans les backend.tf des environnements"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "Nom de la table DynamoDB à réutiliser dans les backend.tf des environnements"
}
