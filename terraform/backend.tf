terraform {
  required_version = ">= 1.5"

  backend "s3" {
    bucket         = "github-actions-demo-terraform-state"
    key            = "lambda/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "github-actions-demo-terraform-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}