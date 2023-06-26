#
# DEV MAIN KEYVAULT
#

module "secrets" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v6.15.2"

  resource_group = local.dev_key_vault_resource_group
  key_vault_name = local.dev_key_vault_azdo_name

  secrets = [
    "azure-devops-github-ro-TOKEN",
    "azure-devops-github-pr-TOKEN",
    "azure-devops-github-rw-TOKEN",
    "azure-devops-github-EMAIL",
    "azure-devops-github-USERNAME",
    "TENANTID",
    "DEV-SUBSCRIPTION-ID",
  ]
}
