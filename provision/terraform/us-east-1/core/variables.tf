variable "namespace" {
  type        = string
  description = "The namespace for project"
}

variable "project" {
  type        = string
  description = "The name for project"
}

variable "repository_domain" {
  type = string
}

variable "repository_owner" {
  type = string
}

variable "repository_name" {
  type = string
}

variable "aws_region" {
  type        = string
  description = "The aws region"
}

variable "key_name" {
  type = string
}

variable "stage" {
  type        = string
  description = "the var for stage (Dev, Staging, Production)"
  default     = "core"
}

variable "github" {
  description = "vars for github"
  type = object({
    token = string
    owner = string
  })
}
