variable "subscription_id" {
  type = string
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "github_org" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_environment" {
  type        = string
  description = "GitHub Environment name used by the deployment workflow"
  default     = "azure-deploy"
}

variable "github_branch" {
  type    = string
  default = "main"
}

variable "rg_name" {
  type = string
}

variable "user_assigned_identity_name" {
  type    = string
}
