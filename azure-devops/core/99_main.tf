terraform {
  required_version = ">= 1.3.2"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.10.0"
    }
    azurerm = {
      version = ">= 3.85.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  alias           = "dev"
  subscription_id = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
}

