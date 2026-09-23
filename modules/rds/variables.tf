variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "subnet_ids" {
  description = "Subnets privés pour héberger la base de données"
  type        = list(string)
}

variable "security_group_id" {
  type = string
}

variable "instance_class" {
  description = "Classe d'instance RDS (ex: db.t3.micro en dev, db.t3.medium+ en prod)"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  description = "Storage autoscaling max (0 pour désactiver)"
  type        = number
  default     = 100
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  description = "Mot de passe DB - à fournir via variable d'environnement TF_VAR_db_password ou secrets manager, jamais commité"
  type        = string
  sensitive   = true
}

variable "multi_az" {
  description = "Active le multi-AZ (haute dispo) - true recommandé pour prod uniquement (coût x2)"
  type        = bool
  default     = false
}
