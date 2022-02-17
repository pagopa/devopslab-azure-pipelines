variable "devops-webapp-k8s" {
  default = {
    repository = {
      organization          = "pagopa"
      name                  = "devops-webapp-k8s"
      branch_name           = "main"
      pipelines_path        = ".devops"
      pipeline_yml_filename = "docker-build.yml"
      pipeline_name         = "devops-webapp-k8s.docker-build"
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
  devops-webapp-k8s-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  devops-webapp-k8s-variables_secret = {

  }
  # code_review vars
  devops-webapp-k8s-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.devops-webapp-k8s.repository.organization
    sonarcloud_project_key  = "${var.devops-webapp-k8s.repository.organization}_${var.devops-webapp-k8s.repository.name}"
    sonarcloud_project_name = var.devops-webapp-k8s.repository.name
  }
  # code_review secrets
  devops-webapp-k8s-variables_secret_code_review = {

  }
  # deploy vars
  devops-webapp-k8s-variables_deploy = {
    k8s_image_repository_name           = replace(var.devops-webapp-k8s.repository.name, "-", "")
    lab_container_registry_service_conn = azuredevops_serviceendpoint_azurecr.azurecr_lab.service_endpoint_name
    lab_container_registry_name         = "${local.docker_registry_name}.azurecr.io"
    vm_agent_pool                       = "${local.vm_agent_pool}"
  }
  # deploy secrets
  devops-webapp-k8s-variables_secret_deploy = {

  }
  # docker build
  devops-webapp-k8s-variables_docker_build = {
    docker_image_repository_name        = replace(var.devops-webapp-k8s.repository.name, "-", "")
    lab_container_registry_service_conn = azuredevops_serviceendpoint_azurecr.azurecr_lab.service_endpoint_name
    lab_container_registry_name         = "${local.docker_registry_name}.azurecr.io"
    vm_agent_pool                       = "${local.vm_agent_pool}"
  }
  # deploy secrets
  devops-webapp-k8s-variables_secret_docker_build = {

  }
}

#
# CODE REVIEW
#
module "devops-webapp-k8s_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.0.4"
  count  = var.devops-webapp-k8s.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = azuredevops_project.project.id
  repository                   = var.devops-webapp-k8s.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.devops-webapp-k8s-variables,
    local.devops-webapp-k8s-variables_code_review,
  )

  variables_secret = merge(
    local.devops-webapp-k8s-variables_secret,
    local.devops-webapp-k8s-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    # local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

#
# DOCKER BUILD
#
module "devops-webapp-k8s_docker_build" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_generic?ref=add-module-build-pipeline-generic"
  count  = var.devops-webapp-k8s.pipeline.enable_docker_build == true ? 1 : 0

  project_id                   = azuredevops_project.project.id
  repository                   = var.devops-webapp-k8s.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id
  pipeline_name                = var.devops-webapp-k8s.repository.pipeline_name
  pipeline_yml_filename        = var.devops-webapp-k8s.repository.pipeline_yml_filename

  ci_trigger_use_yaml = true

  variables = merge(
    local.devops-webapp-k8s-variables,
    local.devops-webapp-k8s-variables_docker_build,
  )

  variables_secret = merge(
    local.devops-webapp-k8s-variables_secret,
    local.devops-webapp-k8s-variables_secret_docker_build,
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
# module "devops-webapp-k8s_deploy" {
#   source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.0.4"
#   count  = var.devops-webapp-k8s.pipeline.enable_deploy == true ? 1 : 0

#   project_id                   = azuredevops_project.project.id
#   repository                   = var.devops-webapp-k8s.repository
#   github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

#   ci_trigger_use_yaml = true

#   variables = merge(
#     local.devops-webapp-k8s-variables,
#     local.devops-webapp-k8s-variables_deploy,
#   )

#   variables_secret = merge(
#     local.devops-webapp-k8s-variables_secret,
#     local.devops-webapp-k8s-variables_secret_deploy,
#   )

#   service_connection_ids_authorization = [
#     azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
#     azuredevops_serviceendpoint_azurerm.LAB-SERVICE-CONN.id,
#     azuredevops_serviceendpoint_azurecr.azurecr_lab.id,
#     azuredevops_serviceendpoint_kubernetes.selfcare-aks-dev.id,
#   ]
# }
