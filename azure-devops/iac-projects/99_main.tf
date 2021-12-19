terraform {
  required_version = ">= 1.0.11"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.1.4"
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
