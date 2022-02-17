# variable "tlscert-lab-devopslab-pagopa-it" {
#   default = {
#     repository = {
#       organization   = "pagopa"
#       name           = "le-azure-acme-tiny"
#       branch_name    = "master"
#       pipelines_path = "."
#     }
#     pipeline = {
#       enable_tls_cert = true
#       path            = "TLS-Certificates\\LAB"
#       dns_record_name = "lab"
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
#   tlscert-lab-devopslab-pagopa-it = {
#     tenant_id                           = module.secrets.values["TENANTID"].value
#     subscription_name                   = var.subscription_name
#     subscription_id                     = module.secrets.values["LAB-SUBSCRIPTION-ID"].value
#     dns_zone_resource_group             = var.key_vault_rg_name
#     credential_subcription              = var.subscription_name
#     credential_key_vault_name           = var.key_vault_name
#     credential_key_vault_resource_group = var.key_vault_rg_name
#     service_connection_ids_authorization = [
#       module.LAB-TLS-CERT-SERVICE-CONN.service_endpoint_id,
#     ]
#   }
#   tlscert-lab-devopslab-pagopa-it-variables = {
#     KEY_VAULT_SERVICE_CONNECTION = module.LAB-TLS-CERT-SERVICE-CONN.service_endpoint_name,
#     KEY_VAULT_NAME               = var.key_vault_name
#   }
#   tlscert-lab-devopslab-pagopa-it-variables_secret = {
#   }
# }

# # change only providers
# #tfsec:ignore:GEN003
# module "tlscert-lab-devopslab-pagopa-it-cert_az" {
#   source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert?ref=v2.0.4"
#   count  = var.tlscert-lab-devopslab-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0

#   # change me
#   providers = {
#     azurerm = azurerm.lab
#   }

#   project_id                   = azuredevops_project.project.id
#   repository                   = var.tlscert-lab-devopslab-pagopa-it.repository
#   name                         = "${var.tlscert-lab-devopslab-pagopa-it.pipeline.dns_record_name}.${var.tlscert-lab-devopslab-pagopa-it.pipeline.dns_zone_name}"
#   renew_token                  = local.tlscert_renew_token
#   path                         = var.tlscert-lab-devopslab-pagopa-it.pipeline.path
#   github_service_connection_id = azuredevops_serviceendpoint_github.azure-devops-github-ro.id

#   dns_record_name         = var.tlscert-lab-devopslab-pagopa-it.pipeline.dns_record_name
#   dns_zone_name           = var.tlscert-lab-devopslab-pagopa-it.pipeline.dns_zone_name
#   dns_zone_resource_group = local.tlscert-lab-devopslab-pagopa-it.dns_zone_resource_group
#   tenant_id               = local.tlscert-lab-devopslab-pagopa-it.tenant_id
#   subscription_name       = local.tlscert-lab-devopslab-pagopa-it.subscription_name
#   subscription_id         = local.tlscert-lab-devopslab-pagopa-it.subscription_id

#   credential_subcription              = local.tlscert-lab-devopslab-pagopa-it.credential_subcription
#   credential_key_vault_name           = local.tlscert-lab-devopslab-pagopa-it.credential_key_vault_name
#   credential_key_vault_resource_group = local.tlscert-lab-devopslab-pagopa-it.credential_key_vault_resource_group

#   variables = merge(
#     var.tlscert-lab-devopslab-pagopa-it.pipeline.variables,
#     local.tlscert-lab-devopslab-pagopa-it-variables,
#   )

#   variables_secret = merge(
#     var.tlscert-lab-devopslab-pagopa-it.pipeline.variables_secret,
#     local.tlscert-lab-devopslab-pagopa-it-variables_secret,
#   )

#   service_connection_ids_authorization = local.tlscert-lab-devopslab-pagopa-it.service_connection_ids_authorization

#   schedules = {
#     days_to_build              = ["Mon"]
#     schedule_only_with_changes = false
#     start_hours                = 3
#     start_minutes              = 0
#     time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
#     branch_filter = {
#       include = ["master"]
#       exclude = []
#     }
#   }
# }
