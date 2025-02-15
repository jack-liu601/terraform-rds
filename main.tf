# RDS Instance
resource "aws_db_instance" "prod_rds_instance" {
  identifier                          = "prod-devops-rds-instance"
  instance_class                      = "db.m5.xlarge"
  allocated_storage                   = 500   # Min storage for 13,000 IOPS = 500
  max_allocated_storage               = 1000  # Allows auto-scaling
  iops                                = 13000 # Provisioned IOPS
  engine                              = "postgres"
  engine_version                      = "13.7"
  port                                = "5432"
  parameter_group_name                = aws_db_parameter_group.prod-rds-param-group.name
  db_subnet_group_name                = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids              = [aws_security_group.rds_security_group.id]
  publicly_accessible                 = false
  storage_type                        = "gp3" # Select gp3 over io1 / io2 due to cost as there was no requirement for max iops but only min. 13000 IOPS
  multi_az                            = true
  iam_database_authentication_enabled = true
  manage_master_user_password         = true
  tags = {
    Name = "prod-devops-rds-instance"
  }
}

# RDS Parameter Group
resource "aws_db_parameter_group" "prod_rds_param_group" {
  name        = "prod-devops-rds-param-group"
  family      = "postgres13"
  description = "Production RDS Custom parameter group"

  parameter {
    name  = "statement_timeout"
    value = "3600000"
  }

  parameter {
    name  = "rds.log_retention_period"
    value = "1440"
  }

  tags = {
    Name = "custom-rds-parameter-group"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "prod_rds_subnet_group" {
  name       = "rds-production-subnet-group"
  subnet_ids = var.rds_subnet_ids

  tags = {
    Name = "prod-devops-rds-subnet-group"
  }
}

# Security Group for RDS
resource "aws_security_group" "prod_rds_sg" {
  name        = "prod-devops-rds-sg"
  description = "Allow EKS application access to RDS"
  vpc_id      = var.rds_vpc_id

  ingress {
    description = "Allow EKS App CIDR: ${eks_vpc_cidr} connection "
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.eks_vpc_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod-devops-rds-sg"
  }
}
