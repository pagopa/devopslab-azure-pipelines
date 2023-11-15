#
# DEV
#

resource "azurerm_key_vault_access_policy" "DEVOPSLAB-TLS-CERT-SERVICE-CONN_kv_access_policy" {
  provider     = azurerm.dev
  key_vault_id = data.azurerm_key_vault.domain_kv_dev.id
  tenant_id    = module.secret_core.values["TENANTID"].value
  object_id    = module.BLUEPRINT-TLS-CERT-SERVICE-CONN.identity_principal_id

  certificate_permissions = ["Get", "Import"]
}

# create let's encrypt credential used to create SSL certificates
module "letsencrypt_dev" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//letsencrypt_credential?ref=v7.20.0"

  providers = {
    azurerm = azurerm.dev
  }
  prefix            = local.prefix
  env               = "d"
  key_vault_name    = local.dev_domain_key_vault_name
  subscription_name = local.dev_subscription_name
}

#----------------------------------------

module "BLUEPRINT-TLS-CERT-SERVICE-CONN" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_federated?ref=v4.0.0"

  providers = {
    azurerm = azurerm.dev
  }

  project_id          = data.azuredevops_project.project.id
  name                = "${local.prefix}-d-${local.domain}-tls-cert"
  tenant_id           = module.secret_core.values["TENANTID"].value
  subscription_name   = local.dev_subscription_name
  subscription_id     = module.secret_core.values["DEV-SUBSCRIPTION-ID"].value
  location            = var.location
  resource_group_name = "default-roleassignment-rg"
}
