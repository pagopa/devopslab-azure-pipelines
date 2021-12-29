module "secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.0.5"

  resource_group = local.lab_key_vault_resource_group
  key_vault_name = local.lab_key_vault_name

  secrets = [
    # "azure-devops-github-ro-TOKEN",
    # "azure-devops-github-pr-TOKEN",
    # "azure-devops-github-EMAIL",
    # "azure-devops-github-USERNAME",
    # "DOCKER-REGISTRY-PAGOPA-USER",
    # "DOCKER-REGISTRY-PAGOPA-TOKEN-RO",
    "TENANTID",
    "DEV-SUBSCRIPTION-ID",
    # "UAT-SUBSCRIPTION-ID",
    # "PROD-SUBSCRIPTION-ID",
  ]
}
