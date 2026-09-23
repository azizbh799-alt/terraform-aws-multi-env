variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  description = "ID du VPC dans lequel créer les security groups"
  type        = string
}

variable "ssh_allowed_cidrs" {
  description = "Liste des CIDR autorisés en SSH (ex: ton IP publique en /32)"
  type        = list(string)
  default     = ["0.0.0.0/0"] # ⚠️ À restreindre en prod à ton IP réelle
}
