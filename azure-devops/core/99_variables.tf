locals {

  azure_devops_org = "pagopaspa"
  project          = "${var.prefix}-${var.env_short}"

  env_location_short = "${var.env}-${var.location_short}"

  # ☁️ VNET
  vnet_resource_group_name = "${local.project}-vnet-rg"
  vnet_name                = "${local.project}-vnet"

  # 📦 ACR LAB DOCKER
  docker_rg_name       = "${local.project}-dockerreg-rg"
  docker_registry_name = replace("${var.prefix}-${var.env_short}-${var.location_short}-acr", "-", "")

  # Agent pool
  vm_agent_pool = "${var.project_name_prefix}-dev-linux"

  # Service endpoints
  srv_endpoint_docker_registry_lab = "srvendpoint-acrdocker-${var.prefix}-${var.env}"

  #tfsec:ignore:GEN003
  #tfsec:ignore:GEN002
  tlscert_renew_token = "v2"
}

# general

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

variable "env" {
  type = string
  validation {
    condition = (
      length(var.env) <= 3
    )
    error_message = "Max length is 3 chars."
  }
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "location" {
  type    = string
  default = ""
}

variable "location_short" {
  type    = string
  default = ""
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

#
# 🔐 Key Vault
#
variable "key_vault_name" {
  type        = string
  description = "Key Vault name"
  default     = ""
}

variable "key_vault_rg_name" {
  type        = string
  default     = ""
  description = "Key Vault - rg name"
}

#--------------------------------------------------------------------------------------------------

variable "subscription_name" {
  type        = string
  description = "LAB Subscription name"
}

variable "project_name_prefix" {
  type        = string
  description = "Project name prefix (e.g. userregistry)"
}


