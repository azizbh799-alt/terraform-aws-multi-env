output "web_sg_id" {
  value = aws_security_group.web.id
}

output "database_sg_id" {
  value = aws_security_group.database.id
}
