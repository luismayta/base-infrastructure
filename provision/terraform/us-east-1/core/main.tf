  module "repository_example" {
    source = "hadenlabs/repository/github"
    version = "0.12.0"

    providers = {
      github = github
    }

    name        = "repository-example"
    description = "github repository for repository"
    visibility  = "public"

  }
