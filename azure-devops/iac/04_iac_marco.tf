variable "marco_iac" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "devopslab-infra"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "marco"
    }
    pipeline = {
      path            = "marco"
    }
  }
}


module "marco_switcher" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_switcher?ref=d5d3367"
  path   = var.marco_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.marco_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-rw.id

  variables = merge(
    local.diego_iac_variables,
    local.diego_iac_variables_deploy,
  )

  variables_secret = merge(
    local.diego_iac_variables_secret,
    local.diego_iac_variables_secret_deploy,
  )



  tenant_id                           = module.secrets.values["TENANTID"].value
  subscription_id                     = module.secrets.values["DEV-SUBSCRIPTION-ID"].value



  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-SERVICE-CONN.id,
  ]

  schedule_configuration = {
    days_to_build = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    timezone = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = ["feat-switcher-pipeline"]
      exclude = []
    }
    aks = [
      {
        cluster_name = "my_cluster_name"
        start_time = "15:20"
        stop_time = "15:30"
        rg = "my_rg"
        user = {
          nodes_on_start = "1,3"
          nodes_on_stop = "0"
        }
        system = {
          nodes_on_start = "1,3"
          nodes_on_stop = "1"
        }
      }
    ]
  }
}
