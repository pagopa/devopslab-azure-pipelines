module "DEV-TLS-CERT-SERVICE-CONN" {
  depends_on = [azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_federated?ref=v9.0.0"
  providers = {
    azurerm = azurerm.dev
  }

  project_id = azuredevops_project.project.id
  #tfsec:ignore:general-secrets-no-plaintext-exposure
  name              = "${local.prefix}-${local.domain}-d-azdo-tls-cert-kv-policy"
  tenant_id         = data.azurerm_client_config.current.tenant_id
  subscription_id   = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
  subscription_name = local.dev_subscription_name

  location            = var.location_northeurope
  resource_group_name = local.dev_identity_rg_name

}

module "letsencrypt_dev_italy" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential?ref=v8.21.0"

  prefix            = "dvopla"
  env               = "d"
  key_vault_name    = "dvopla-d-itn-core-kv"
  subscription_name = "devopslab"
}

data "azurerm_key_vault" "kv_dev" {
  provider            = azurerm.dev
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}

resource "azurerm_key_vault_access_policy" "DEV-TLS-CERT-SERVICE-CONN_kv_dev" {
  provider = azurerm.dev

  key_vault_id = data.azurerm_key_vault.kv_dev.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.DEV-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}
