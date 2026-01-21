  module "repository_example" {
    source = "hadenlabs/repository/github"
    version = "1.0.0"

    providers = {
      github = github
    }

    name        = "repository-example"
    description = "github repository for repository"
    visibility  = "public"

  }
