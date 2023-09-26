variable "switcher_iac" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "eng-common-scripts"
      branch_name     = "refs/heads/main"
      pipelines_path  = "devops"
      yml_prefix_name = null
    }

    pipeline = {
      path = "switcher"
    }
  }
}

locals {
  variables = {
    TF_AZURE_SERVICE_CONNECTION_NAME = azuredevops_serviceendpoint_azurerm.DEV-SERVICE-CONN.service_endpoint_name
    TF_AZURE_DEVOPS_POOL_AGENT_NAME : "devopslab-dev-linux"
  }
}


module "resource_switcher" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_resource_switcher?ref=v3.9.0"
  path   = var.switcher_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.switcher_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-rw.id

  variables        = local.variables
  variables_secret = {}


  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-SERVICE-CONN.id,
  ]

  timeout = 40

  schedule_configuration = {
    days_to_build = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    timezone      = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = ["main"]
      exclude = []
    }
    aks = [
      {
        cluster_name = "dvopla-d-neu-dev01-aks"
        start_time   = "08:00"
        stop_time    = "20:00"
        rg           = "dvopla-d-neu-dev01-aks-rg"
        force        = true
        user = {
          nodes_on_start = "1,3"
          nodes_on_stop  = "0,0"
        }
        system = {
          nodes_on_start = "1,3"
          nodes_on_stop  = "1,1"
        }
      }
    ]
    sa_sftp = []
  }
}
