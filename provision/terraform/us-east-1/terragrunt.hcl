terraform {
  extra_arguments "retry_lock" {
    commands = get_terraform_commands_that_need_locking()
    arguments = [
      "-lock-timeout=40m"
    ]
  }
}

remote_state {
  backend = "s3"
  config = {
    bucket  = local.terragrunt_bucket
    encrypt = true
    # Configure Terragrunt to automatically store tfstate files in an S3 bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    dynamodb_table = local.terragrunt_dynamodb_table

    s3_bucket_tags = {
      owner = "terragrunt infrastructure luismayta"
      name  = "Terraform state storage"
    }

    #   # dynamodb_table_tags is an attribute, so an equals sign is REQUIRED
    dynamodb_table_tags = {
      owner = "terragrunt infrastructure luismayta"
      name  = "Terraform lock table"
    }
  }
}

inputs = {
  namespace  = local.namespace
  project    = local.project
  aws_region = local.region
  key_name   = local.key_name

  # repository
  repository_domain = local.repository_domain
  repository_owner  = local.repository_owner
  repository_name   = local.repository_name

  github = {
    token = local.github_token
    owner = local.github_owner
  }
}

locals {
  team                 = "luismayta"
  namespace                 = get_env("NAMESPACE", "luismayta")
  project                   = get_env("PROJECT", "infrastructure")
  region                    = get_env("AWS_DEFAULT_REGION", "us-east-1")
  key_name                  = local.project
  github_owner              = get_env("GITHUB_OWNER", "")
  github_token              = get_env("GITHUB_TOKEN", "")
  repository_domain         = "github.com"
  repository_owner          = local.team
  repository_name           = local.project
  terragrunt_bucket         = format("%s-%s-terraform-state-%s", local.team, local.project, local.region)
  terragrunt_dynamodb_table = format("%s-%s-%s", local.team, local.project, local.region)
}
