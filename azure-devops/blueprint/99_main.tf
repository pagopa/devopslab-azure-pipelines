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
  subscription_id = module.secret_core.values["DEV-SUBSCRIPTION-ID"].value
}

# data "terraform_remote_state" "core" {
#   backend = "azurerm"

#   config = {
#     resource_group_name  = var.terraform_remote_state_core.resource_group_name
#     storage_account_name = var.terraform_remote_state_core.storage_account_name
#     container_name       = var.terraform_remote_state_core.container_name
#     key                  = var.terraform_remote_state_core.key
#   }
# }
