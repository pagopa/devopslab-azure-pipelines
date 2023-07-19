variable "devops-webapp-python" {
  default = {
    repository = {
      organization          = "pagopa"
      name                  = "devops-webapp-python"
      branch_name           = "refs/heads/main"
      pipelines_path        = ".devops"
      pipeline_yml_filename = "docker-build.yml"
      pipeline_name         = "devops-webapp-python.docker-build"
      yml_prefix_name       = null
    }
    pipeline = {
      enable_code_review  = true
      enable_docker_build = true
      enable_deploy       = true
    }
  }
}

locals {
  # global vars
  devops-webapp-python-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  devops-webapp-python-variables_secret = {

  }
  # code_review vars
  devops-webapp-python-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.devops-webapp-python.repository.organization
    sonarcloud_project_key  = "${var.devops-webapp-python.repository.organization}_${var.devops-webapp-python.repository.name}"
    sonarcloud_project_name = var.devops-webapp-python.repository.name
  }
  # code_review secrets
  devops-webapp-python-variables_secret_code_review = {

  }
  # deploy vars
  devops-webapp-python-variables_deploy = {
    k8s_image_repository_name           = replace(var.devops-webapp-python.repository.name, "-", "")
    lab_container_registry_service_conn = azuredevops_serviceendpoint_azurecr.azurecr_lab.service_endpoint_name
    lab_container_registry_name         = "${local.docker_registry_name}.azurecr.io"
    vm_agent_pool                       = "${local.vm_agent_pool}"
  }
  # deploy secrets
  devops-webapp-python-variables_secret_deploy = {

  }
  # docker build
  devops-webapp-python-variables_docker_build = {
    docker_image_repository_name        = replace(var.devops-webapp-python.repository.name, "-", "")
    lab_container_registry_service_conn = azuredevops_serviceendpoint_azurecr.azurecr_lab.service_endpoint_name
    lab_container_registry_name         = "${local.docker_registry_name}.azurecr.io"
    vm_agent_pool                       = "${local.vm_agent_pool}"
  }
  # deploy secrets
  devops-webapp-python-variables_secret_docker_build = {

  }
}

#
# CODE REVIEW
#
module "devops-webapp-python_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.7.0"
  count  = var.devops-webapp-python.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = azuredevops_project.project.id
  repository                   = var.devops-webapp-python.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id
  path = var.devops-webapp-python.repository.name

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.devops-webapp-python-variables,
    local.devops-webapp-python-variables_code_review,
  )

  variables_secret = merge(
    local.devops-webapp-python-variables_secret,
    local.devops-webapp-python-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    # local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

#
# DOCKER BUILD
#
module "devops-webapp-python_docker_build" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_generic?ref=v2.6.5"
  count  = var.devops-webapp-python.pipeline.enable_docker_build == true ? 1 : 0

  project_id                   = azuredevops_project.project.id
  repository                   = var.devops-webapp-python.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id
  pipeline_name                = var.devops-webapp-python.repository.pipeline_name
  pipeline_yml_filename        = var.devops-webapp-python.repository.pipeline_yml_filename
  path                         = var.devops-webapp-python.repository.name

  ci_trigger_use_yaml = true

  variables = merge(
    local.devops-webapp-python-variables,
    local.devops-webapp-python-variables_docker_build,
  )

  variables_secret = merge(
    local.devops-webapp-python-variables_secret,
    local.devops-webapp-python-variables_secret_docker_build,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.LAB-SERVICE-CONN.id,
    azuredevops_serviceendpoint_azurecr.azurecr_lab.id,
  ]
}

# #
# # DEPLOY
# #
# module "devops-webapp-python_deploy" {
#   source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.7.0"
#   count  = var.devops-webapp-python.pipeline.enable_deploy == true ? 1 : 0

#   project_id                   = azuredevops_project.project.id
#   repository                   = var.devops-webapp-python.repository
#   github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

#   ci_trigger_use_yaml = true

#   variables = merge(
#     local.devops-webapp-python-variables,
#     local.devops-webapp-python-variables_deploy,
#   )

#   variables_secret = merge(
#     local.devops-webapp-python-variables_secret,
#     local.devops-webapp-python-variables_secret_deploy,
#   )

#   service_connection_ids_authorization = [
#     azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
#     azuredevops_serviceendpoint_azurerm.LAB-SERVICE-CONN.id,
#     azuredevops_serviceendpoint_azurecr.azurecr_lab.id,
#     azuredevops_serviceendpoint_kubernetes.selfcare-aks-dev.id,
#   ]
# }
