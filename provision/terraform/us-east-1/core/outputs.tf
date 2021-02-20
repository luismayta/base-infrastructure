output "repository_example" {
  description = "show url git of repository-example"
  value       = module.repository_example.instance.git_clone_url
}
