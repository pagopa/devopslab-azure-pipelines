terraform {
  required_version = ">= 1.3.5"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "<= 1.3.0"
    }
    azurerm = {
      version = "<= 3.116.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.47.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "<= 0.11.0"
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
  subscription_id = module.secret_core.values["DEV-SUBSCRIPTION-ID"].value
}

