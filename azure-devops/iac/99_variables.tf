locals {
  prefix           = "devopslab"
  azure_devops_org = "pagopaspa"
  project_name     = "devops-platform-iac-projects"

  # Service connections/ End points
  srv_endpoint_github_ro = "io-azure-devops-github-ro"
  srv_endpoint_github_rw = "io-azure-devops-github-rw"
  srv_endpoint_github_pr = "io-azure-devops-github-pr"

  # 🔐 KV AZDO
  dev_key_vault_azdo_name      = "dvopla-d-neu-kv"
  dev_key_vault_resource_group = "dvopla-d-sec-rg"

  # 🔐 KV Domain
  dev_diego_key_vault_resource_group = "dvopla-d-diego-sec-rg"
  dev_diego_key_vault_name           = "dvopla-d-diego-kv"

}

variable "dev_subscription_name" {
  type        = string
  description = "DEV Subscription name"
}

variable "project_name_prefix" {
  type        = string
  description = "Project name prefix (e.g. userregistry)"
}

variable "aks_dev_platform_name" {
  type        = string
  description = "AKS DEV platform name"
}

variable "aks_dev_platform_resource_group" {
  type        = string
  description = "AKS DEV platform resource group"
}
