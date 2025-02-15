terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
  }
  required_version = "~> 1.8.4"
}

provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      Environment = "prod"
      Owner       = "devops"
    }
  }
}

terraform {
  backend "s3" {
    # Assumption on the bucket state has already been created 
    bucket = "terraform-state-bucket-dmo"
    key    = "terraform-stack"
    region = "ap-southeast-2"
    # Update Profile dependent on AWS Organisation / Account 
    profile = "saml"
  }
}

