resource "aws_kms_key" "rds_kms_cmk" {
  description             = "KMS CMK for RDS encryption"
  deletion_window_in_days = 30
  is_enabled              = true
  enable_key_rotation     = true

  tags = {
    Name = "rds-kms-cmk"
  }
}
