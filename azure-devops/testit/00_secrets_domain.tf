#
# PROD ECOMMERCE KEYVAULT
#

module "domain_dev_secrets" {

  providers = {
    azurerm = azurerm.dev
  }

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v8.14.0"

  resource_group = local.dev_domain_key_vault_resource_group
  key_vault_name = local.dev_domain_key_vault_name

  secrets = [
    "dvopla-d-itn-dev-aks-apiserver-url",
    "dvopla-d-itn-dev-aks-azure-devops-sa-cacrt",
    "dvopla-d-itn-dev-aks-azure-devops-sa-token",
  ]
}
