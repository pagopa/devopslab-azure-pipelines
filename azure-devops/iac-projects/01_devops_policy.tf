# # azure devops policy
# data "azuread_service_principal" "iac_principal" {
#   count        = var.enable_iac_pipeline ? 1 : 0
#   display_name = format("pagopaspa-pagoPA-iac-projects-%s", data.azurerm_subscription.current.subscription_id)
# }

# resource "azurerm_key_vault_access_policy" "azdevops_iac_policy" {
#   count        = var.enable_iac_pipeline ? 1 : 0
#   key_vault_id = data.azurerm_key_vault.kv.id
#   tenant_id    = data.azurerm_client_config.current.tenant_id
#   object_id    = data.azuread_service_principal.iac_principal[0].object_id

#   secret_permissions      = ["Get", "List", "Set", ]
#   certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
#   storage_permissions     = []
# }
