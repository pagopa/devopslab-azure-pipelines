variable "diego_iac" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "devopslab-infra"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "diego"
    }
    pipeline = {
      enable_code_review   = true
      enable_deploy        = true
      path                 = "diego-domain"
      pipeline_name_prefix = "diego-domain"
    }
  }
}

locals {
  # global vars
  diego_iac_variables = {
    tf_aks_dev_name                  = var.aks_dev_platform_name
    tf_dev_azure_service_connection  = azuredevops_serviceendpoint_azurerm.DEV-SERVICE-CONN.service_endpoint_name
  }
  # global secrets
  diego_iac_variables_secret = {}

  # code_review vars
  diego_iac_variables_code_review = {}
  # code_review secrets
  diego_iac_variables_secret_code_review = {}

  # deploy vars
  diego_iac_variables_deploy = {}
  # deploy secrets
  diego_iac_variables_secret_deploy = {}
}

module "diego_iac_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.2"
  count  = var.diego_iac.pipeline.enable_code_review == true ? 1 : 0
  path   = var.diego_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.diego_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-rw.id

  pipeline_name_prefix = var.diego_iac.pipeline.pipeline_name_prefix

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.diego_iac_variables,
    local.diego_iac_variables_code_review,
  )

  variables_secret = merge(
    local.diego_iac_variables_secret,
    local.diego_iac_variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-SERVICE-CONN.id,
  ]
}

module "diego_iac_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.2"
  count  = var.diego_iac.pipeline.enable_deploy == true ? 1 : 0
  path   = var.diego_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.diego_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-rw.id

  pipeline_name_prefix = var.diego_iac.pipeline.pipeline_name_prefix

  ci_trigger_use_yaml           = false
  pull_request_trigger_use_yaml = false

  variables = merge(
    local.diego_iac_variables,
    local.diego_iac_variables_deploy,
  )

  variables_secret = merge(
    local.diego_iac_variables_secret,
    local.diego_iac_variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-SERVICE-CONN.id,
  ]
}
