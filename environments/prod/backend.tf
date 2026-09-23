terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    # ⚠️ Remplace par le nom de bucket créé via backend-setup/
    bucket         = "REPLACE-WITH-YOUR-STATE-BUCKET-NAME"
    key            = "env:/prod/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

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
