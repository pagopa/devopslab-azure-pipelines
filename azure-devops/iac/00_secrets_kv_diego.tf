#
# diego KEYVAULT
#

module "diego_dev_secrets" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v6.15.2"

  providers = {
    azurerm = azurerm.dev
  }

  resource_group = local.dev_diego_key_vault_resource_group
  key_vault_name = local.dev_diego_key_vault_name

  secrets = [
    "dvopla-d-neu-dev01-aks-azure-devops-sa-token",
    "dvopla-d-neu-dev01-aks-azure-devops-sa-cacrt",
    "dvopla-d-neu-dev01-aks-apiserver-url"
  ]
}
