<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.5 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.47.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | <= 0.12.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.64 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | <= 0.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.11.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.64.0 |
| <a name="provider_azurerm.dev"></a> [azurerm.dev](#provider\_azurerm.dev) | 3.64.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_DEV-PRINTIT-TLS-CERT-SERVICE-CONN"></a> [DEV-PRINTIT-TLS-CERT-SERVICE-CONN](#module\_DEV-PRINTIT-TLS-CERT-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_federated | v7.1.0 |
| <a name="module_domain_dev_secrets"></a> [domain\_dev\_secrets](#module\_domain\_dev\_secrets) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v8.14.0 |
| <a name="module_letsencrypt_dev"></a> [letsencrypt\_dev](#module\_letsencrypt\_dev) | git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential | v7.1.0 |
| <a name="module_secret_core"></a> [secret\_core](#module\_secret\_core) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query | v8.14.0 |
| <a name="module_tlscert-testit-itn-internal-devopslab-pagopa-it-cert_az"></a> [tlscert-testit-itn-internal-devopslab-pagopa-it-cert\_az](#module\_tlscert-testit-itn-internal-devopslab-pagopa-it-cert\_az) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert_federated | v7.1.0 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_serviceendpoint_kubernetes.aks_dev](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_kubernetes) | resource |
| [azurerm_key_vault_access_policy.DEV-PRINTIT-TLS-CERT-SERVICE-CONN_kv_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azuredevops_serviceendpoint_azurerm.azure_dev](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/serviceendpoint_azurerm) | data source |
| [azuredevops_serviceendpoint_github.github_rw](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/serviceendpoint_github) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.domain_kv_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_subscriptions.dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dev_subscription_name"></a> [dev\_subscription\_name](#input\_dev\_subscription\_name) | DEV Subscription name | `string` | n/a | yes |
| <a name="input_identity_rg_name"></a> [identity\_rg\_name](#input\_identity\_rg\_name) | Identity rg common for all identities | `string` | n/a | yes |
| <a name="input_internal_devopslab_dns_private_rg_name"></a> [internal\_devopslab\_dns\_private\_rg\_name](#input\_internal\_devopslab\_dns\_private\_rg\_name) | rg name for internal dns private | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_location_ita"></a> [location\_ita](#input\_location\_ita) | n/a | `string` | n/a | yes |
| <a name="input_location_short_ita"></a> [location\_short\_ita](#input\_location\_short\_ita) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"dvopla"` | no |
| <a name="input_project_name_prefix"></a> [project\_name\_prefix](#input\_project\_name\_prefix) | Project name prefix (e.g. userregistry) | `string` | n/a | yes |
| <a name="input_service_endpoint_azure_dev_name"></a> [service\_endpoint\_azure\_dev\_name](#input\_service\_endpoint\_azure\_dev\_name) | azure service endpoint name for dev | `string` | n/a | yes |
| <a name="input_service_endpoint_azure_dev_name_prefix"></a> [service\_endpoint\_azure\_dev\_name\_prefix](#input\_service\_endpoint\_azure\_dev\_name\_prefix) | service connection prefix, used by apps for azurerm connection | `string` | n/a | yes |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | LAB Subscription name | `string` | n/a | yes |
| <a name="input_tlscert-testit-itn-internal-devopslab-pagopa-it"></a> [tlscert-testit-itn-internal-devopslab-pagopa-it](#input\_tlscert-testit-itn-internal-devopslab-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "testit.itn.internal",<br>    "dns_zone_name": "devopslab.pagopa.it",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\DEV",<br>    "variables": {<br>      "CERT_NAME_EXPIRE_SECONDS": "2592000"<br>    },<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
