terraform {
  required_version = ">= 1.3.5"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "<= 0.10.0"
    }
    azurerm = {
      version = "= 2.99.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.30.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.1"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.7.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

provider "azurerm" {
  alias = "dev"
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
  subscription_id = data.azurerm_subscriptions.dev.id
}

data "azurerm_client_config" "current" {}

data "azurerm_subscriptions" "dev" {
  display_name_prefix = var.dev_subscription_name
}
