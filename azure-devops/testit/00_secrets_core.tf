#
# CORE KEYVAULT
#

module "secret_core" {
  source = "./.terraform/modules/__v3__/key_vault_secrets_query"

  resource_group = local.core_key_vault_resource_group
  key_vault_name = local.core_key_vault_azdo_name

  secrets = [
    "azure-devops-github-ro-TOKEN",
    "azure-devops-github-rw-TOKEN",
    "azure-devops-github-pr-TOKEN",
  ]
}
