# 🟢 LAB service connection for azure container registry 
resource "azuredevops_serviceendpoint_azurecr" "azurecr_lab" {
  depends_on = [azuredevops_project.project]

  project_id     = azuredevops_project.project.id
  service_endpoint_name = local.srv_endpoint_docker_registry_lab

  resource_group = local.docker_rg_name
  azurecr_name          = local.docker_registry_name

  azurecr_subscription_name = var.subscription_name
  azurecr_spn_tenantid      = module.secrets.values["TENANTID"].value
  azurecr_subscription_id   = module.secrets.values["LAB-SUBSCRIPTION-ID"].value
}
