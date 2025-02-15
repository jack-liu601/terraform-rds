data "aws_region" "current" {}

data "aws_secretsmanager_secret" "data_prod_secret" {
  name = "prod-devops-rds-master-pw"

  depends_on = [
    aws_secretsmanager_secret.prod_rds_secret
  ]
}

data "aws_secretsmanager_secret_version" "data_prod_secret_version" {
  secret_id = data.aws_secretsmanager_secret.data_prod_secret_id.id
}

