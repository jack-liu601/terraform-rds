# Creating ouputs of rds endpoint and security group ids for clarity
output "prod_rds_endpoint" {
  description = "Production RDS endpoint"
  value       = aws_db_instance.prod_rds_instance.endpoint
}

output "prod_rds_sg_id" {
  description = "Production RDS Security group ID"
  value       = aws_security_group.prod_rds_sg.id
}
