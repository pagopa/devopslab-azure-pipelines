resource "azuredevops_serviceendpoint_kubernetes" "aks_dev" {
  depends_on            = [data.azuredevops_project.project]
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = local.srv_endpoint_name_aks_dev
  apiserver_url         = module.domain_dev_secrets.values["cstar-d-weu-dev01-aks-apiserver-url"].value
  authorization_type    = "ServiceAccount"
  service_account {
    # base64 values
    token   = module.domain_dev_secrets.values["cstar-d-weu-dev01-aks-azure-devops-sa-token"].value
    ca_cert = module.domain_dev_secrets.values["cstar-d-weu-dev01-aks-azure-devops-sa-cacrt"].value
  }
}

resource "azuredevops_serviceendpoint_kubernetes" "aks_uat" {
  depends_on            = [data.azuredevops_project.project]
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = local.srv_endpoint_name_aks_uat
  apiserver_url         = module.domain_uat_secrets.values["cstar-u-weu-uat01-aks-apiserver-url"].value
  authorization_type    = "ServiceAccount"
  service_account {
    # base64 values
    token   = module.domain_uat_secrets.values["cstar-u-weu-uat01-aks-azure-devops-sa-token"].value
    ca_cert = module.domain_uat_secrets.values["cstar-u-weu-uat01-aks-azure-devops-sa-cacrt"].value
  }
}

resource "azuredevops_serviceendpoint_kubernetes" "aks_prod" {
  depends_on            = [data.azuredevops_project.project]
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = local.srv_endpoint_name_aks_prod
  apiserver_url         = module.domain_prod_secrets.values["cstar-p-weu-prod01-aks-apiserver-url"].value
  authorization_type    = "ServiceAccount"
  service_account {
    # base64 values
    token   = module.domain_prod_secrets.values["cstar-p-weu-prod01-aks-azure-devops-sa-token"].value
    ca_cert = module.domain_prod_secrets.values["cstar-p-weu-prod01-aks-azure-devops-sa-cacrt"].value
  }
}
