module "vpc" {
  source = "../../modules/vpc"

  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = "10.0.0.0/16"
  enable_nat_gateway = false # désactivé en dev pour économiser (~30$/mois de moins)
}

module "security_groups" {
  source = "../../modules/security-groups"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  ssh_allowed_cidrs = [var.my_ip_cidr]
}

module "ec2" {
  source = "../../modules/ec2"

  project_name       = var.project_name
  environment        = var.environment
  instance_type      = "t2.micro"
  subnet_ids         = module.vpc.public_subnet_ids # public en dev pour accès direct simplifié
  security_group_id  = module.security_groups.web_sg_id
  min_size           = 1
  max_size           = 1
  desired_capacity   = 1
}

module "rds" {
  source = "../../modules/rds"

  project_name       = var.project_name
  environment        = var.environment
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_id  = module.security_groups.database_sg_id
  instance_class     = "db.t3.micro"
  multi_az           = false
  db_password        = var.db_password
}
