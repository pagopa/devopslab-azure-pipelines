variable "devops-java-springboot-color" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "devops-java-springboot-color"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "diego\\devops-java-springboot-color"
    }
  }
}

locals {
  # global vars
  devops-java-springboot-color-variables = {
    dockerfile = "Dockerfile"
    DEV_AGENT_POOL = local.azdo_agent_pool_dev

  }
  # global secrets
  devops-java-springboot-color-variables_secret = {

  }
  # code_review vars
  devops-java-springboot-color-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.devops-java-springboot-color.repository.organization
    sonarcloud_project_key  = "${var.devops-java-springboot-color.repository.organization}_${var.devops-java-springboot-color.repository.name}"
    sonarcloud_project_name = var.devops-java-springboot-color.repository.name
  }
  # code_review secrets
  devops-java-springboot-color-variables_secret_code_review = {

  }
  # deploy vars
  devops-java-springboot-color-variables_deploy = {
    K8S_IMAGE_REPOSITORY_NAME        = replace(var.devops-java-springboot-color.repository.name, "-", "")
    DEPLOY_NAMESPACE                 = local.domain
    SETTINGS_XML_RW_SECURE_FILE_NAME = "settings-rw.xml"
    SETTINGS_XML_RO_SECURE_FILE_NAME = "settings-ro.xml"
    HELM_RELEASE_NAME                = var.devops-java-springboot-color.repository.name
    DEV_KUBERNETES_SERVICE_CONN = local.srv_endpoint_name_aks_dev
  }
  # deploy secrets
  devops-java-springboot-color-variables_secret_deploy = {

  }
}

module "devops-java-springboot-color_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.7.0"
  count  = var.devops-java-springboot-color.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.devops-java-springboot-color.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id
  path                         = var.devops-java-springboot-color.pipeline.path

  ci_trigger_use_yaml           = true
  pull_request_trigger_use_yaml = true

  variables = merge(
    local.devops-java-springboot-color-variables,
    local.devops-java-springboot-color-variables_code_review,
  )

  variables_secret = merge(
    local.devops-java-springboot-color-variables_secret,
    local.devops-java-springboot-color-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_ro_id,
    local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

module "devops-java-springboot-color_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.7.0"
  count  = var.devops-java-springboot-color.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.devops-java-springboot-color.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id
  path                         = var.devops-java-springboot-color.pipeline.path
  ci_trigger_use_yaml          = true

  variables = merge(
    local.devops-java-springboot-color-variables,
    local.devops-java-springboot-color-variables_deploy,
  )

  variables_secret = merge(
    local.devops-java-springboot-color-variables_secret,
    local.devops-java-springboot-color-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_pr_id,

    local.service_endpoint_azure_dev_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]

}
