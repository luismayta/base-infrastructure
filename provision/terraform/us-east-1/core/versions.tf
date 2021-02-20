terraform {
  required_version = ">=0.13"
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.25.0"
    }

    github = {
      source  = "integrations/github"
      version = ">=4.5.0"
    }

  }
}
