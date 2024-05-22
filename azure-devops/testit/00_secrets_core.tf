#
# CORE KEYVAULT
#

module "secret_core" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v8.14.0"

  resource_group = local.core_key_vault_resource_group
  key_vault_name = local.core_key_vault_azdo_name

  secrets = [
    "azure-devops-github-ro-TOKEN",
    "azure-devops-github-rw-TOKEN",
    "azure-devops-github-pr-TOKEN",
  ]
}
