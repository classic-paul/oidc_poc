terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Auth comes from ARM_CLIENT_ID, ARM_TENANT_ID, ARM_SUBSCRIPTION_ID and ARM_USE_OIDC=true
provider "azurerm" {
  features {}
  use_oidc = true
}

data "azurerm_resource_group" "this" {
  name = var.rg_name
}

resource "azurerm_logic_app_workflow" "this" {
  name                = var.logic_app_workflow_name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
}
