variable "aws_region" {
  description = "Région AWS où créer le bucket S3 et la table DynamoDB"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Nom du projet, utilisé pour le tagging"
  type        = string
  default     = "aws-multi-env-infra"
}

variable "state_bucket_name" {
  description = "Nom du bucket S3 (doit être globalement unique sur AWS)"
  type        = string
  # À personnaliser avant le premier apply, ex: "aziz-terraform-state-2026"
}

variable "dynamodb_table_name" {
  description = "Nom de la table DynamoDB pour le state locking"
  type        = string
  default     = "terraform-locks"
}
