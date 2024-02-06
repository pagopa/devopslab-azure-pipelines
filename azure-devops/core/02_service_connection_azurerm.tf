# 🟢 LAB service connection
resource "azuredevops_serviceendpoint_azurerm" "LAB-SERVICE-CONN" {
  depends_on = [azuredevops_project.project]

  project_id                = azuredevops_project.project.id
  service_endpoint_name     = "${var.subscription_name}-SERVICE-CONN"
  description               = "${var.subscription_name} Service connection"
  azurerm_subscription_name = var.subscription_name
  azurerm_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurerm_subscription_id   = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
}
