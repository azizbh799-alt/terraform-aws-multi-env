variable "project_name" {
  description = "Nom du projet, utilisé dans le tagging et le nommage des ressources"
  type        = string
}

variable "environment" {
  description = "Nom de l'environnement (dev, staging, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloc CIDR du VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Liste des CIDR pour les subnets publics (un par AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Liste des CIDR pour les subnets privés (un par AZ)"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "enable_nat_gateway" {
  description = "Active le NAT Gateway (payant) - mettre à false en dev pour économiser"
  type        = bool
  default     = true
}
