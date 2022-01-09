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

#--------------------------------------------------------------------------------------------------

variable "lab_subscription_name" {
  type        = string
  description = "LAB Subscription name"
}

variable "project_name_prefix" {
  type        = string
  description = "Project name prefix (e.g. userregistry)"
}

locals {

  azure_devops_org = "pagopaspa"

  env_location_short           = "${var.env}-${var.location_short}"
  project                      = "${var.prefix}-${var.env}"

  # 🔐 KV
  lab_key_vault_name = "kv-${var.prefix}-${var.env}-${var.location_short}"

  lab_key_vault_resource_group = "rg-${var.prefix}-sec-${local.env_location_short}"

  # ☁️ VNET
  lab_vnet_rg = "rg-vnet-${local.project}"

  # 📦 ACR LAB DOCKER
  docker_rg_name = "rg-docker-${var.env}"
  docker_registry_name = replace("acr-${var.prefix}-${var.env}", "-", "")

  lab_docker_rg_name = "rg-docker-lab"
  lab_docker_registry_name = replace("acr-${var.prefix}-lab", "-", "")

  # Agent pool
  lab_agent_pool = "${var.project_name_prefix}-lab-linux"
  
  # Service endpoints
  srv_endpoint_docker_registry_lab = "srvendpoint-acrdocker-${var.prefix}-${var.env}"

  #tfsec:ignore:GEN003
  #tfsec:ignore:GEN002
  tlscert_renew_token = "v1"


}
