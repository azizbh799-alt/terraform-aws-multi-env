variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance_type" {
  description = "Type d'instance EC2 (ex: t2.micro pour dev, t3.medium pour prod)"
  type        = string
  default     = "t2.micro"
}

variable "subnet_ids" {
  description = "Liste des subnets où déployer les instances (privés recommandé)"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID du security group à attacher aux instances"
  type        = string
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 2
}

variable "desired_capacity" {
  type    = number
  default = 1
}
