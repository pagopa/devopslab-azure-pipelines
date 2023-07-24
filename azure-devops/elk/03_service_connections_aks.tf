resource "azuredevops_serviceendpoint_kubernetes" "aks_dev" {
  depends_on            = [data.azuredevops_project.project]
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = local.srv_endpoint_name_aks_dev
  apiserver_url         = module.domain_dev_secrets.values["dvopla-d-neu-dev01-aks-apiserver-url"].value
  authorization_type    = "ServiceAccount"
  service_account {
    # base64 values
    token   = module.domain_dev_secrets.values["dvopla-d-neu-dev01-aks-azure-devops-sa-token"].value
    ca_cert = module.domain_dev_secrets.values["dvopla-d-neu-dev01-aks-azure-devops-sa-cacrt"].value
  }
}
