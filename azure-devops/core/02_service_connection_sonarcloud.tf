locals {
  azuredevops_serviceendpoint_sonarcloud_token = ""
}

resource "azuredevops_serviceendpoint_sonarcloud" "sonarcloud" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "SONARCLOUD-SERVICE-CONN"
  token                 = local.azuredevops_serviceendpoint_sonarcloud_token
  description           = "Managed by Terraform"
}
