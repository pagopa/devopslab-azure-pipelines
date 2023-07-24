data "azuredevops_serviceendpoint_azurerm" "azure_dev" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "${var.subscription_name}-SERVICE-CONN"
}
