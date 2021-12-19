terraform {
  required_version = ">= 1.0.11"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.1.8"
    }
    azurerm = {
      version = ">= 2.90.0"
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
