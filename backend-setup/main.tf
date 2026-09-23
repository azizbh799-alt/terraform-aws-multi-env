terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Bucket S3 pour stocker les fichiers terraform.tfstate de tous les environnements
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket_name

  # Empêche la suppression accidentelle du bucket contenant les states
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name    = "Terraform State Bucket"
    Project = var.project_name
  }
}

# Versioning : permet de revenir à un état précédent en cas de corruption du state
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Chiffrement au repos du bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bloque tout accès public au bucket (contient des infos sensibles sur l'infra)
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Table DynamoDB utilisée pour le state locking (empêche 2 "terraform apply" simultanés)
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = "Terraform Lock Table"
    Project = var.project_name
  }
}
