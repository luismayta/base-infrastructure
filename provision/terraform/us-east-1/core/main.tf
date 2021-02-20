  module "main" {
    source = "hadenlabs/repository/github"
    version = "0.4.0"

    providers = {
      github = github
    }

    name        = "repository-example"
    description = "github repository for repository"
    visibility  = "public"

  }
