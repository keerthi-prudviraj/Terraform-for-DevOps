terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "pr-remote-infra-s3"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "pr-dynamodb-table"
  }
}