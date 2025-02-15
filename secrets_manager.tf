# Random password generation
resource "random_password" "rds_master_password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

# Secrets Manager RDS Master Password Secret
resource "aws_secretsmanager_secret" "prod_rds_secret" {
  name                    = "prod-devops-rds-master-pw"
  kms_key_id              = aws_kms_key.rds_kms_cmk.key_id
  description             = "Production rds master password"
  recovery_window_in_days = 15
  tags = {
    Name = "prod-devops-rds-pw"
  }
}

# Secrets Manager RDS Master Pasword Version
resource "aws_secretsmanager_secret_version" "prod" {
  secret_id     = aws_secretsmanager_secret.prod_rds_secret.id
  secret_string = random_password.rds_master_password.result
}

