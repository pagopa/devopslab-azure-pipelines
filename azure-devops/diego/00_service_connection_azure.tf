data "azuredevops_serviceendpoint_azurerm" "azure_dev" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = var.service_endpoint_azure_dev_name
}

data "azuredevops_serviceendpoint_azurerm" "azure_uat" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = var.service_endpoint_azure_uat_name
}

data "azuredevops_serviceendpoint_azurerm" "azure_prod" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = var.service_endpoint_azure_prod_name
}
