locals {
  prefix           = var.prefix
  azure_devops_org = "pagopaspa"
  domain           = "blueprint"

  # 🔐 KV AZDO
  core_key_vault_resource_group = "dvopla-d-itn-sec-rg"
  core_key_vault_azdo_name      = "dvopla-d-itn-core-kv"

  # 🔐 KV Domain
  dev_domain_key_vault_resource_group = "${local.prefix}-d-${local.domain}-sec-rg"
  dev_domain_key_vault_name           = "${local.prefix}-d-${local.domain}-kv"

  # ☁️ VNET
  dev_vnet_rg = "${local.prefix}-d-vnet-rg"

  # DNS Zone

  rg_dev_dns_zone_name = "${local.prefix}-d-vnet-rg"

  dev_dns_zone_name = "devopslab.pagopa.it"

  # 📦 ACR DEV FOR AKS
  aks_dev_docker_registry_rg_name = "${local.prefix}-d-container-registry-rg"
  aks_dev_docker_registry_name    = "${local.prefix}dcommonacr"

  # AKS
  srv_endpoint_name_aks_dev = "${local.prefix}-${local.domain}-aks-dev"

  # Agent Pool
  azdo_agent_pool_dev = "${local.dev_subscription_name}-dev-linux"

  # Subscription Name
  dev_subscription_name = "devopslab"

  #tfsec:ignore:GEN002
  tlscert_renew_token = "v2"

  # TODO azure devops terraform provider does not support SonarCloud service endpoint
  azuredevops_serviceendpoint_sonarcloud_id = "9182be64-d387-465d-9acc-e79e802910c8"

}

variable "project_name_prefix" {
  type        = string
  description = "Project name prefix (e.g. userregistry)"
}

variable "prefix" {
  type    = string
  default = "dvopla"
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

#
# Subscription
#

variable "dev_subscription_name" {
  type        = string
  description = "DEV Subscription name"
}

variable "subscription_name" {
  type        = string
  description = "LAB Subscription name"
}

variable "service_endpoint_azure_dev_name" {
  type        = string
  description = "azure service endpoint name for dev"
}

variable "service_endpoint_azure_dev_name_prefix" {
  type        = string
  description = "service connection prefix, used by apps for azurerm connection"
}
