#
# PROD ECOMMERCE KEYVAULT
#

# module "domain_dev_secrets" {

#   providers = {
#     azurerm = azurerm.dev
#   }

#   source = "git::https://github.com/pagopa/terraform-azurerm-v3//key_vault_secrets_query?ref=v7.20.0"

#   resource_group = local.dev_domain_key_vault_resource_group
#   key_vault_name = local.dev_domain_key_vault_name

#   secrets = [
#     "dvopla-d-neu-dev01-aks-apiserver-url",
#     "dvopla-d-neu-dev01-aks-azure-devops-sa-cacrt",
#     "dvopla-d-neu-dev01-aks-azure-devops-sa-token",
#   ]
# }
