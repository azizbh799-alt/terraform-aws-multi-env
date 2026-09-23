variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "project_name" {
  type    = string
  default = "myapp"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "my_ip_cidr" {
  description = "Ton IP publique en /32 pour restreindre SSH (ex: 41.229.x.x/32)"
  type        = string
  default     = "0.0.0.0/0" # ⚠️ à remplacer par ta vraie IP
}

variable "db_password" {
  description = "Mot de passe de la base de données - fournir via TF_VAR_db_password"
  type        = string
  sensitive   = true
}
