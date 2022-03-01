variable "devops-helm-template" {
  default = {
    repository = {
      organization          = "pagopa"
      name                  = "template-microservizio-k8s"
      branch_name           = "main"
      pipelines_path        = ".devops"
      pipeline_yml_filename = "build.yml"
      pipeline_name         = "template-microservizio-k8s.build"
      yml_prefix_name       = null
    }
    pipeline = {
      enable_code_review  = false
      enable_docker_build = true
      enable_deploy       = true
    }
  }
}

locals {
  # global vars
  devops-helm-template-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  devops-helm-template-variables_secret = {

  }
  # code_review vars
  devops-helm-template-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.devops-helm-template.repository.organization
    sonarcloud_project_key  = "${var.devops-helm-template.repository.organization}_${var.devops-helm-template.repository.name}"
    sonarcloud_project_name = var.devops-helm-template.repository.name
  }
  # code_review secrets
  devops-helm-template-variables_secret_code_review = {

  }
  # deploy vars
  devops-helm-template-variables_deploy = {
    k8s_image_repository_name           = replace(var.devops-helm-template.repository.name, "-", "")
    dev_container_registry_service_conn = azuredevops_serviceendpoint_azurecr.azurecr_lab.service_endpoint_name
    dev_kubernetes_service_conn         = azuredevops_serviceendpoint_kubernetes.aks-dev.service_endpoint_name
    dev_container_registry_name         = "${local.docker_registry_name}.azurecr.io"
    dev_agent_pool                      = "${var.prefix}-dev-linux"
  }
  # deploy secrets
  devops-helm-template-variables_secret_deploy = {

  }
  # docker build
  devops-helm-template-variables_docker_build = {
    docker_image_repository_name        = replace(var.devops-helm-template.repository.name, "-", "")
    dev_container_registry_service_conn = azuredevops_serviceendpoint_azurecr.azurecr_lab.service_endpoint_name
    dev_container_registry_name         = "${local.docker_registry_name}.azurecr.io"
  }
  # deploy secrets
  devops-helm-template-variables_secret_docker_build = {

  }
}

#
# CODE REVIEW
#
module "devops-helm-template_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.0.4"
  count  = var.devops-helm-template.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = azuredevops_project.project.id
  repository                   = var.devops-helm-template.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.devops-helm-template-variables,
    local.devops-helm-template-variables_code_review,
  )

  variables_secret = merge(
    local.devops-helm-template-variables_secret,
    local.devops-helm-template-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    # local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

#
# DOCKER BUILD
#
module "devops-helm-template_docker_build" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_generic?ref=add-module-build-pipeline-generic"
  count  = var.devops-helm-template.pipeline.enable_docker_build == true ? 1 : 0

  project_id                   = azuredevops_project.project.id
  repository                   = var.devops-helm-template.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id
  pipeline_name                = var.devops-helm-template.repository.pipeline_name
  pipeline_yml_filename        = var.devops-helm-template.repository.pipeline_yml_filename

  ci_trigger_use_yaml = true

  variables = merge(
    local.devops-helm-template-variables,
    local.devops-helm-template-variables_docker_build,
  )

  variables_secret = merge(
    local.devops-helm-template-variables_secret,
    local.devops-helm-template-variables_secret_docker_build,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.LAB-SERVICE-CONN.id,
    azuredevops_serviceendpoint_azurecr.azurecr_lab.id,
  ]
}

#
# DEPLOY
#
module "devops-helm-template_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.0.4"
  count  = var.devops-helm-template.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = azuredevops_project.project.id
  repository                   = var.devops-helm-template.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-pr.id

  ci_trigger_use_yaml = true

  variables = merge(
    local.devops-helm-template-variables,
    local.devops-helm-template-variables_deploy,
  )

  variables_secret = merge(
    local.devops-helm-template-variables_secret,
    local.devops-helm-template-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.LAB-SERVICE-CONN.id,
    azuredevops_serviceendpoint_azurecr.azurecr_lab.id,
    azuredevops_serviceendpoint_kubernetes.aks-dev.id,
  ]
}
