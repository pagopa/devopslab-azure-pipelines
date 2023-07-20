module "secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v4.17.0"

  resource_group = var.key_vault_rg_name
  key_vault_name = var.key_vault_name

  secrets = [
    "azure-devops-github-ro-TOKEN",
    "azure-devops-github-rw-TOKEN",
    "azure-devops-github-pr-TOKEN",
    "aks-azure-devops-sa-token",
    "aks-azure-devops-sa-cacrt",
    # "azure-devops-github-EMAIL",
    # "azure-devops-github-USERNAME",
    # "DOCKER-REGISTRY-PAGOPA-USER",
    # "DOCKER-REGISTRY-PAGOPA-TOKEN-RO",
    "TENANTID",
    "LAB-SUBSCRIPTION-ID",
    "DEV-SUBSCRIPTION-ID",
    # "UAT-SUBSCRIPTION-ID",
    # "PROD-SUBSCRIPTION-ID",
  ]
}
