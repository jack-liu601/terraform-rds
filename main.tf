# RDS Instance
resource "aws_db_instance" "rds_instance" {
  identifier                          = "production-rds-instance"
  instance_class                      = "db.m5.xlarge" 
  allocated_storage                   = 500           # Min storage for 13,000 IOPS = 500
  max_allocated_storage               = 1000          # Allows auto-scaling
  iops                                = 13000         # Provisioned IOPS
  engine                              = "postgres"    
  engine_version                      = "13.7"        
  parameter_group_name                = aws_db_parameter_group.custom_rds_parameter_group.name
  db_subnet_group_name                = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids              = [aws_security_group.rds_security_group.id]
  publicly_accessible                 = false
  storage_type                        = "gp3"         # Select gp3 over io1 / io2 due to cost as there was no requirement for max iops but only min. 13000
  multi_az                            = true  
  iam_database_authentication_enabled = true
  username                            = "admin"
  password                            = data.aws_secretsmanager_secret_version.data_prod_secret_version.secret_string
  tags = {
    Name        = "prod-devops-rds-instance"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-production-subnet-group"
  subnet_ids = var.rds_subnet_ids

  tags = {
    Name = "prod-devops-rds-subnet-group"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_security_group" {
  name        = "rds-production-sg"
  description = "Allow connections from EKS VPC to RDS"
  vpc_id      = var.rds_vpc_id

  ingress {
    description = "Allow MySQL/Aurora connections from EKS VPC"
    from_port   = 3306
    to_port     = 3306
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