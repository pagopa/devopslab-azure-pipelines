<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.5 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.47.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | <= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | <= 0.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 1.3.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |
| <a name="provider_azurerm.dev"></a> [azurerm.dev](#provider\_azurerm.dev) | 3.116.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_DIEGO-TLS-CERT-SERVICE-CONN"></a> [DIEGO-TLS-CERT-SERVICE-CONN](#module\_DIEGO-TLS-CERT-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_federated | v9.0.0 |
| <a name="module_devopslab_diego_deploy"></a> [devopslab\_diego\_deploy](#module\_devopslab\_diego\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_generic | v9.2.1 |
| <a name="module_domain_dev_secrets"></a> [domain\_dev\_secrets](#module\_domain\_dev\_secrets) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v8.21.0 |
| <a name="module_secret_core"></a> [secret\_core](#module\_secret\_core) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v8.21.0 |
| <a name="module_tlscert-diego-itn-internal-devopslab-pagopa-it-cert_az"></a> [tlscert-diego-itn-internal-devopslab-pagopa-it-cert\_az](#module\_tlscert-diego-itn-internal-devopslab-pagopa-it-cert\_az) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert_federated | v9.0.0 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_serviceendpoint_kubernetes.aks_dev](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_kubernetes) | resource |
| [azurerm_key_vault_access_policy.DIEGO-TLS-CERT-SERVICE-CONN_kv_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azuredevops_serviceendpoint_azurerm.azure_dev](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/serviceendpoint_azurerm) | data source |
| [azuredevops_serviceendpoint_github.azure-devops-github-rw](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/serviceendpoint_github) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.domain_kv_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_subscriptions.dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dev_subscription_name"></a> [dev\_subscription\_name](#input\_dev\_subscription\_name) | DEV Subscription name | `string` | n/a | yes |
| <a name="input_devopslab_diego_deploy"></a> [devopslab\_diego\_deploy](#input\_devopslab\_diego\_deploy) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "name": "devopslab-diego-deploy",<br>    "path": "diego\\devopslab-diego-deploy"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "devopslab-diego-deploy",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops"<br>  }<br>}</pre> | no |
| <a name="input_location_northeurope"></a> [location\_northeurope](#input\_location\_northeurope) | n/a | `string` | `""` | no |
| <a name="input_location_short_northeurope"></a> [location\_short\_northeurope](#input\_location\_short\_northeurope) | n/a | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"dvopla"` | no |
| <a name="input_project_name_prefix"></a> [project\_name\_prefix](#input\_project\_name\_prefix) | Project name prefix (e.g. userregistry) | `string` | n/a | yes |
| <a name="input_service_endpoint_azure_dev_name"></a> [service\_endpoint\_azure\_dev\_name](#input\_service\_endpoint\_azure\_dev\_name) | azure service endpoint name for dev | `string` | n/a | yes |
| <a name="input_service_endpoint_azure_dev_name_prefix"></a> [service\_endpoint\_azure\_dev\_name\_prefix](#input\_service\_endpoint\_azure\_dev\_name\_prefix) | service connection prefix, used by apps for azurerm connection | `string` | n/a | yes |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | LAB Subscription name | `string` | n/a | yes |
| <a name="input_tlscert-diego-itn-internal-devopslab-pagopa-it"></a> [tlscert-diego-itn-internal-devopslab-pagopa-it](#input\_tlscert-diego-itn-internal-devopslab-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "diego.itn.internal",<br>    "dns_zone_name": "devopslab.pagopa.it",<br>    "dns_zone_resource_group": "dvopla-d-itn-vnet-rg",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\DEV",<br>    "variables": {},<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
