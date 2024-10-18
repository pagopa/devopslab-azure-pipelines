# #
# # DEV
# #
# module "DEVOPSLAB-TLS-CERT-SERVICE-CONN" {

#   providers = {
#     azurerm = azurerm.dev
#   }

#   depends_on = [data.azuredevops_project.project]
#   source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v2.1.0"

#   project_id        = data.azuredevops_project.project.id
#   name              = "${local.prefix}-d-${local.domain}-tls-cert"
#   tenant_id         = data.azurerm_client_config.current.tenant_id
#   subscription_name = local.dev_subscription_name
#   subscription_id   = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
#   #tfsec:ignore:GEN003
#   renew_token = local.tlscert_renew_token

#   credential_subcription              = local.dev_subscription_name
#   credential_key_vault_name           = local.dev_domain_key_vault_name
#   credential_key_vault_resource_group = local.dev_domain_key_vault_resource_group
# }

# resource "azurerm_key_vault_access_policy" "DEVOPSLAB-TLS-CERT-SERVICE-CONN_kv_access_policy" {
#   provider     = azurerm.dev
#   key_vault_id = data.azurerm_key_vault.domain_kv_dev.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = module.DEVOPSLAB-TLS-CERT-SERVICE-CONN.service_principal_object_id

#   certificate_permissions = ["Get", "Import"]
# }

# # create let's encrypt credential used to create SSL certificates
# module "letsencrypt_dev" {
#   source = "git::https://github.com/pagopa/azurerm.git//letsencrypt_credential?ref=v2.18.0"

#   providers = {
#     azurerm = azurerm.dev
#   }
#   prefix            = local.prefix
#   env               = "d"
#   key_vault_name    = local.dev_domain_key_vault_name
#   subscription_name = local.dev_subscription_name
# }
