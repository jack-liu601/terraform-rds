output "rds_endpoint" {
  description = "Production RDS endpoint"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_security_group_id" {
  description = "Production RDS Security group ID"
  value       = aws_security_group.rds_security_group.ids
}
