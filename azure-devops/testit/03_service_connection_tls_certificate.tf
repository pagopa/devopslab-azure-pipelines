#
# DEV
#
module "DEV-PRINTIT-TLS-CERT-SERVICE-CONN" {

  providers = {
    azurerm = azurerm.dev
  }

  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_federated?ref=v7.1.0"

  project_id        = data.azuredevops_project.project.id
  name              = "${local.prefix}-d-${local.domain}-tls-cert"
  tenant_id         = data.azurerm_client_config.current.tenant_id
  subscription_name = local.dev_subscription_name
  subscription_id   = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id

  resource_group_name = var.identity_rg_name
  location            = var.location

}

resource "azurerm_key_vault_access_policy" "DEV-PRINTIT-TLS-CERT-SERVICE-CONN_kv_access_policy" {
  provider     = azurerm.dev
  key_vault_id = data.azurerm_key_vault.domain_kv_dev.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.DEV-PRINTIT-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

# create let's encrypt credential used to create SSL certificates
module "letsencrypt_dev" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential?ref=v7.1.0"

  providers = {
    azurerm = azurerm.dev
  }
  prefix            = local.prefix
  env               = "d"
  key_vault_name    = local.dev_domain_key_vault_name
  subscription_name = var.dev_subscription_name
}
