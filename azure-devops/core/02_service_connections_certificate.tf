#
# ⛩ Service connection 2 🔐 KV@LAB 🟢
#
#tfsec:ignore:GEN003
module "LAB-TLS-CERT-SERVICE-CONN" {
  depends_on = [azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v6.0.0"
  providers = {
    azurerm = azurerm.lab
  }

  project_id        = azuredevops_project.project.id
  renew_token       = local.tlscert_renew_token
  name              = "cert-tls-${local.project}"
  tenant_id         = data.azurerm_client_config.current.tenant_id
  subscription_id   = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
  subscription_name = var.subscription_name

  credential_subcription              = var.subscription_name
  credential_key_vault_name           = var.key_vault_name
  credential_key_vault_resource_group = var.key_vault_rg_name
}

data "azurerm_key_vault" "kv_lab" {
  provider = azurerm.lab

  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}

resource "azurerm_key_vault_access_policy" "LAB-TLS-CERT-SERVICE-CONN_kv_lab" {
  provider = azurerm.lab

  key_vault_id = data.azurerm_key_vault.kv_lab.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.LAB-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}
