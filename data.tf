# Calling Region & Caller Identity Data to allow easy dynamic reference when needed i.e. IAM role creation... etc
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
