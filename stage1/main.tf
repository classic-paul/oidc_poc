terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_user_assigned_identity" "this" {
  name                = var.user_assigned_identity_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

resource "azurerm_role_assignment" "contributor" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

resource "azurerm_federated_identity_credential" "github_environment" {
  name                      = "github-${var.github_environment}"
  user_assigned_identity_id = azurerm_user_assigned_identity.this.id
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  subject                   = "repo:${var.github_org}/${var.github_repo}:environment:${var.github_environment}"
}

# Branch-specific alternative. Set github_branch and use this subject instead
# when the credential should trust only one branch.
# resource "azurerm_federated_identity_credential" "github_main" {
#   name                      = "github-${var.github_branch}"
#   user_assigned_identity_id = azurerm_user_assigned_identity.this.id
#   audience                  = ["api://AzureADTokenExchange"]
#   issuer                    = "https://token.actions.githubusercontent.com"
#   subject                   = "repo:${var.github_org}/${var.github_repo}:ref:refs/heads/${var.github_branch}"
# }
