module "secrets" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v7.48.0"

  resource_group = var.key_vault_rg_name
  key_vault_name = var.key_vault_name

  secrets = [
    "azure-devops-github-ro-TOKEN",
    "azure-devops-github-rw-TOKEN",
    "azure-devops-github-pr-TOKEN",
    "aks-azure-devops-sa-token",
    "aks-azure-devops-sa-cacrt",
  ]
}
