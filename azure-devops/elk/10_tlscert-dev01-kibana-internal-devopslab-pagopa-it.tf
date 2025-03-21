# variable "tlscert-dev01-kibana-internal-devopslab-pagopa-it" {
#   default = {
#     repository = {
#       organization   = "pagopa"
#       name           = "le-azure-acme-tiny"
#       branch_name    = "refs/heads/master"
#       pipelines_path = "."
#     }
#     pipeline = {
#       enable_tls_cert = true
#       path            = "TLS-Certificates"
#       dns_record_name = "dev01.kibana.internal"
#       dns_zone_name   = "devopslab.pagopa.it"
#       # common variables to all pipelines
#       variables = {
#         CERT_NAME_EXPIRE_SECONDS = "2592000" #30 days
#       }
#       # common secret variables to all pipelines
#       variables_secret = {
#       }
#     }
#   }
# }

# locals {
#   tlscert-dev01-kibana-internal-devopslab-pagopa-it = {
#     tenant_id                           = data.azurerm_client_config.current.tenant_id
#     subscription_name                   = local.dev_subscription_name
#     subscription_id                     = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
#     dns_zone_resource_group             = local.rg_dev_dns_zone_name
#     credential_subcription              = local.dev_subscription_name
#     credential_key_vault_name           = local.dev_domain_key_vault_name
#     credential_key_vault_resource_group = local.dev_domain_key_vault_resource_group
#     service_connection_ids_authorization = [
#       module.DEVOPSLAB-TLS-CERT-SERVICE-CONN.service_endpoint_id,
#     ]
#   }
#   tlscert-dev01-kibana-internal-devopslab-pagopa-it-variables = {
#     KEY_VAULT_SERVICE_CONNECTION = module.DEVOPSLAB-TLS-CERT-SERVICE-CONN.service_endpoint_name,
#     KEY_VAULT_NAME               = local.dev_domain_key_vault_name
#   }
#   tlscert-dev01-kibana-internal-devopslab-pagopa-it-variables_secret = {
#   }
# }

# # change only providers
# #tfsec:ignore:general-secrets-no-plaintext-exposure
# module "tlscert-dev01-kibana-internal-devopslab-pagopa-it-cert_az" {
#   source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert?ref=v2.6.5"
#   count  = var.tlscert-dev01-kibana-internal-devopslab-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0

#   # change me
#   providers = {
#     azurerm = azurerm.dev
#   }

#   project_id = data.azuredevops_project.project.id
#   repository = var.tlscert-dev01-kibana-internal-devopslab-pagopa-it.repository
#   name       = "${var.tlscert-dev01-kibana-internal-devopslab-pagopa-it.pipeline.dns_record_name}.${var.tlscert-dev01-kibana-internal-devopslab-pagopa-it.pipeline.dns_zone_name}"
#   #tfsec:ignore:general-secrets-no-plaintext-exposure
#   #tfsec:ignore:GEN003
#   renew_token                  = local.tlscert_renew_token
#   path                         = "${local.domain}\\${var.tlscert-dev01-kibana-internal-devopslab-pagopa-it.pipeline.path}"
#   github_service_connection_id = data.azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id

#   dns_record_name         = var.tlscert-dev01-kibana-internal-devopslab-pagopa-it.pipeline.dns_record_name
#   dns_zone_name           = var.tlscert-dev01-kibana-internal-devopslab-pagopa-it.pipeline.dns_zone_name
#   dns_zone_resource_group = local.tlscert-dev01-kibana-internal-devopslab-pagopa-it.dns_zone_resource_group
#   tenant_id               = local.tlscert-dev01-kibana-internal-devopslab-pagopa-it.tenant_id
#   subscription_name       = local.tlscert-dev01-kibana-internal-devopslab-pagopa-it.subscription_name
#   subscription_id         = local.tlscert-dev01-kibana-internal-devopslab-pagopa-it.subscription_id

#   credential_subcription              = local.tlscert-dev01-kibana-internal-devopslab-pagopa-it.credential_subcription
#   credential_key_vault_name           = local.tlscert-dev01-kibana-internal-devopslab-pagopa-it.credential_key_vault_name
#   credential_key_vault_resource_group = local.tlscert-dev01-kibana-internal-devopslab-pagopa-it.credential_key_vault_resource_group

#   variables = merge(
#     var.tlscert-dev01-kibana-internal-devopslab-pagopa-it.pipeline.variables,
#     local.tlscert-dev01-kibana-internal-devopslab-pagopa-it-variables,
#   )

#   variables_secret = merge(
#     var.tlscert-dev01-kibana-internal-devopslab-pagopa-it.pipeline.variables_secret,
#     local.tlscert-dev01-kibana-internal-devopslab-pagopa-it-variables_secret,
#   )

#   service_connection_ids_authorization = local.tlscert-dev01-kibana-internal-devopslab-pagopa-it.service_connection_ids_authorization

#   schedules = {
#     days_to_build              = ["Mon"]
#     schedule_only_with_changes = false
#     start_hours                = 3
#     start_minutes              = 0
#     time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
#     branch_filter = {
#       include = [var.tlscert-dev01-kibana-internal-devopslab-pagopa-it.repository.branch_name]
#       exclude = []
#     }
#   }

#   depends_on = [
#     module.letsencrypt_dev
#   ]
# }
