locals {
  azuredevops_serviceendpoint_sonarcloud_token = "ac94be3073c61272d49968a851115595587044cf"
}

resource "azuredevops_serviceendpoint_sonarcloud" "sonarcloud" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "SONARCLOUD-SERVICE-CONN"
  token                 = local.azuredevops_serviceendpoint_sonarcloud_token
  description           = "Managed by Terraform"
}
