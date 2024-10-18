#
# PROD ECOMMERCE KEYVAULT
#

module "domain_dev_secrets" {

  providers = {
    azurerm = azurerm.dev
  }

  source = "./.terraform/modules/__v3__/key_vault_secrets_query"

  resource_group = local.dev_domain_key_vault_resource_group
  key_vault_name = local.dev_domain_key_vault_name

  secrets = [
    "dvopla-d-itn-dev-aks-apiserver-url",
    "dvopla-d-itn-dev-aks-azure-devops-sa-cacrt",
    "dvopla-d-itn-dev-aks-azure-devops-sa-token",
  ]
}
