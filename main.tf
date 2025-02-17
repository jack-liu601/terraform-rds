/*
  Justification:
  Selected m series graviton instance type due to cost and performance versus the rest of the instance type.
  The brief does not have an requirement in terms of instance type. Therefore, opted for general purpose instead of compute / memory type instance which comes does come with more cost.
  In addition gp3 storage type over io1 / io2 due to cost as there was no requirement for max iops but only min. 13000 IOPS
*/

# RDS Instance
resource "aws_db_instance" "prod_rds_instance" {
  identifier                          = "prod-devops-rds-instance"
  instance_class                      = "db.m6g.xlarge"
  allocated_storage                   = 500   # Min storage for 13,000 IOPS = 500
  max_allocated_storage               = 1000  # Allows auto-scaling
  iops                                = 13000 # Provisioned IOPS
  engine                              = "postgres"
  engine_version                      = "17.3"
  port                                = "5432"
  parameter_group_name                = aws_db_parameter_group.prod_rds_param_group.name
  db_subnet_group_name                = aws_db_subnet_group.prod_rds_subnet_group.name
  vpc_security_group_ids              = [aws_security_group.prod_rds_sg.id]
  publicly_accessible                 = false
  storage_type                        = "gp3" # Select gp3 over io1 / io2 due to cost as there was no requirement for max iops but only min. 13000 IOPS
  multi_az                            = true
  iam_database_authentication_enabled = true
  username                            = "dbsuperuser"
  manage_master_user_password         = true
  storage_encrypted                   = true
  tags = {
    Name = "prod-devops-rds-instance"
  }
}

# RDS Parameter Group
resource "aws_db_parameter_group" "prod_rds_param_group" {
  name        = "prod-devops-rds-param-group"
  family      = "postgres17"
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
  name       = "prod-devops-rds-subnet-group"
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
    description = "Allow EKS App CIDR: ${var.eks_vpc_cidr} connection "
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    # Only allowing ingress connection from EKS App CIDR for security purposes
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
