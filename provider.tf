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
  # Default tag ensuring that minimum tagging standards are applied when deployed via terraform.
  default_tags {
    tags = {
      Environment = "prod"
      Owner       = "devops"
    }
  }
}

terraform {
  backend "s3" {
    # Creating s3 teraform statefile as an backup ensure terraform state is stored and handled properly
    bucket = "terraform-state-bucket-dmo"
    key    = "terraform-stack"
    region = "ap-southeast-2"
    # Update Profile as required
    profile = "saml"
  }
}

