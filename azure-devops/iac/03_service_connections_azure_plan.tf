#
# DEV
#
module "DEV-PLAN-SERVICE-CONN" {

  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_plan?ref=v3.1.1"

  name_suffix                 = "${local.prefix}-dev"
  iac_aad_group_name          = "azure-devops-iac-service-connection"
  password_time_rotation_days = 365
  renew_token                 = "v2"

  project_id      = data.azuredevops_project.project.id
  tenant_id       = module.secrets.values["TENANTID"].value
  subscription_id = module.secrets.values["DEV-SUBSCRIPTION-ID"].value

  credential_key_vault_name           = local.dev_diego_key_vault_name
  credential_key_vault_resource_group = local.dev_diego_key_vault_resource_group
}
