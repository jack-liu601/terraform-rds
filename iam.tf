/*
Justification: 
As per stated in the README.md we assume that an existing application/example-app role has already been created. 
Therefore the focus is to add additional permissions and grants in order to allow this role to authenticae to the DB
*/
resource "aws_iam_role_policy_attachment" "prod_rds_policy_attachment" {
  role       = var.app_role_name
  policy_arn = aws_iam_policy.prod_rds_connect_policy.arn

  depends_on = [aws_iam_policy.prod_rds_connect_policy]
}

data "aws_iam_policy_document" "prod_rds_connect_doc" {
  statement {
    sid = "AllowAppProdDBConnect"
    actions = [
      "rds-db:connect"
    ]
    resources = [
      "arn:aws:rds-db:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_db_instance.prod_rds_instance.resource_id}/db_user"
    ]
  }
}

resource "aws_iam_policy" "prod_rds_connect_policy" {
  name        = "prod-devops-rds-connect-policy"
  description = "EKS IAM authentication policy for connection to Production DB"
  policy      = data.aws_iam_policy_document.prod_rds_connect_doc.json
}
