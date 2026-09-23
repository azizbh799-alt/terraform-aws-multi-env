module "vpc" {
  source = "../../modules/vpc"

  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = "10.2.0.0/16"
  enable_nat_gateway = true
}

module "security_groups" {
  source = "../../modules/security-groups"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  ssh_allowed_cidrs = [var.my_ip_cidr] # ⚠️ en prod, restreindre à un bastion/VPN, pas une IP perso
}

module "ec2" {
  source = "../../modules/ec2"

  project_name      = var.project_name
  environment       = var.environment
  instance_type     = "t3.medium"
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security_groups.web_sg_id
  min_size          = 2
  max_size          = 6
  desired_capacity  = 2
}

module "rds" {
  source = "../../modules/rds"

  project_name       = var.project_name
  environment        = var.environment
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_id  = module.security_groups.database_sg_id
  instance_class     = "db.t3.medium"
  multi_az           = true # haute dispo activée uniquement en prod
  db_password        = var.db_password
}
