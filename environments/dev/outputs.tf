output "vpc_id" {
  value = module.vpc.vpc_id
}

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "autoscaling_group_name" {
  value = module.ec2.autoscaling_group_name
}
