# 🟢 LAB service connection
resource "azuredevops_serviceendpoint_azurerm" "LAB-SERVICE-CONN" {
  depends_on = [azuredevops_project.project]

  project_id                = azuredevops_project.project.id
  service_endpoint_name     = "${var.subscription_name}-SERVICE-CONN"
  description               = "${var.subscription_name} Service connection"
  azurerm_subscription_name = var.subscription_name
  azurerm_spn_tenantid      = module.secrets.values["TENANTID"].value
  azurerm_subscription_id   = module.secrets.values["LAB-SUBSCRIPTION-ID"].value
}
