<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.5 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 0.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.53.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.11.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_DEV-PLAN-SERVICE-CONN"></a> [DEV-PLAN-SERVICE-CONN](#module\_DEV-PLAN-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_plan | v3.1.1 |
| <a name="module_diego_dev_secrets"></a> [diego\_dev\_secrets](#module\_diego\_dev\_secrets) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v6.15.2 |
| <a name="module_diego_iac_code_review"></a> [diego\_iac\_code\_review](#module\_diego\_iac\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v3.1.1 |
| <a name="module_diego_iac_deploy"></a> [diego\_iac\_deploy](#module\_diego\_iac\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v3.1.1 |
| <a name="module_resource_switcher"></a> [resource\_switcher](#module\_resource\_switcher) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_resource_switcher | v3.9.0 |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v6.15.2 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_project_features.project_features](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/project_features) | resource |
| [azuredevops_serviceendpoint_azurerm.DEV-SERVICE-CONN](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_github.azure-devops-github-pr](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.azure-devops-github-ro](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.azure-devops-github-rw](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_team.external_team](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/team) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_dev_platform_name"></a> [aks\_dev\_platform\_name](#input\_aks\_dev\_platform\_name) | AKS DEV platform name | `string` | n/a | yes |
| <a name="input_aks_dev_platform_resource_group"></a> [aks\_dev\_platform\_resource\_group](#input\_aks\_dev\_platform\_resource\_group) | AKS DEV platform resource group | `string` | n/a | yes |
| <a name="input_dev_subscription_name"></a> [dev\_subscription\_name](#input\_dev\_subscription\_name) | DEV Subscription name | `string` | n/a | yes |
| <a name="input_diego_iac"></a> [diego\_iac](#input\_diego\_iac) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "diego-domain",<br>    "pipeline_name_prefix": "diego-domain"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "devopslab-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "diego"<br>  }<br>}</pre> | no |
| <a name="input_project_name_prefix"></a> [project\_name\_prefix](#input\_project\_name\_prefix) | Project name prefix (e.g. userregistry) | `string` | n/a | yes |
| <a name="input_switcher_iac"></a> [switcher\_iac](#input\_switcher\_iac) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "path": "switcher"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "eng-common-scripts",<br>    "organization": "pagopa",<br>    "pipelines_path": "devops",<br>    "yml_prefix_name": null<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
