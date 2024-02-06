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
  alias           = "lab"
  subscription_id = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
}

provider "azurerm" {
  features {}
  alias           = "dev"
  subscription_id = module.secrets.values["DEV-SUBSCRIPTION-ID"].value
}

provider "azurerm" {
  features {}
  alias           = "uat"
  subscription_id = module.secrets.values["UAT-SUBSCRIPTION-ID"].value
}

provider "azurerm" {
  features {}
  alias           = "prod"
  subscription_id = module.secrets.values["PROD-SUBSCRIPTION-ID"].value
}
