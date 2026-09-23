# Security Group pour les instances web (EC2 accessibles depuis internet via ALB ou SSH)
resource "aws_security_group" "web" {
  name        = "${var.project_name}-${var.environment}-web-sg"
  description = "Autorise HTTP/HTTPS entrants et SSH restreint"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH (restreint à une IP/CIDR de confiance)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }

  egress {
    description = "Tout le trafic sortant autorisé"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-web-sg"
    Environment = var.environment
  }
}

# Security Group pour la base de données (accessible uniquement depuis le SG web)
resource "aws_security_group" "database" {
  name        = "${var.project_name}-${var.environment}-db-sg"
  description = "Autorise uniquement le trafic depuis le security group web"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL/Aurora depuis les instances web uniquement"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-sg"
    Environment = var.environment
  }
}
