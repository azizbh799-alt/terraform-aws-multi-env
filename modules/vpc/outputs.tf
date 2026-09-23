output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID du VPC créé"
}

output "vpc_cidr" {
  value       = aws_vpc.main.cidr_block
  description = "Bloc CIDR du VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "IDs des subnets publics"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "IDs des subnets privés"
}
