variable "tlscert-diego-itn-internal-devopslab-pagopa-it" {
  default = {
    repository = {
      organization   = "pagopa"
      name           = "le-azure-acme-tiny"
      branch_name    = "refs/heads/master"
      pipelines_path = "."
    }
    pipeline = {
      enable_tls_cert         = true
      path                    = "TLS-Certificates\\DEV"
      dns_record_name         = "diego.itn.internal"
      dns_zone_name           = "devopslab.pagopa.it"
      dns_zone_resource_group = "dvopla-d-itn-vnet-rg"
      # common variables to all pipelines
      variables = {

      }
      # common secret variables to all pipelines
      variables_secret = {
      }
    }
  }
}

locals {
  tlscert-diego-itn-internal-devopslab-pagopa-it = {
    tenant_id         = data.azurerm_client_config.current.tenant_id
    subscription_name = local.dev_subscription_name
    subscription_id   = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
  }
  tlscert-diego-itn-internal-devopslab-pagopa-it-variables = {
    KEY_VAULT_SERVICE_CONNECTION = module.DIEGO-TLS-CERT-SERVICE-CONN.service_endpoint_name
  }
  tlscert-diego-itn-internal-devopslab-pagopa-it-variables_secret = {
  }
}

module "tlscert-diego-itn-internal-devopslab-pagopa-it-cert_az" {

  providers = {
    azurerm = azurerm.dev
  }

  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert_federated?ref=v9.0.0"
  count  = var.tlscert-diego-itn-internal-devopslab-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0

  project_id = data.azuredevops_project.project.id
  repository = var.tlscert-diego-itn-internal-devopslab-pagopa-it.repository
  #tfsec:ignore:GEN003
  path                         = var.tlscert-diego-itn-internal-devopslab-pagopa-it.pipeline.path
  github_service_connection_id = data.azuredevops_serviceendpoint_github.azure-devops-github-rw.id

  dns_record_name                      = var.tlscert-diego-itn-internal-devopslab-pagopa-it.pipeline.dns_record_name
  dns_zone_name                        = var.tlscert-diego-itn-internal-devopslab-pagopa-it.pipeline.dns_zone_name
  dns_zone_resource_group              = var.tlscert-diego-itn-internal-devopslab-pagopa-it.pipeline.dns_zone_resource_group
  tenant_id                            = local.tlscert-diego-itn-internal-devopslab-pagopa-it.tenant_id
  subscription_name                    = local.tlscert-diego-itn-internal-devopslab-pagopa-it.subscription_name
  subscription_id                      = local.tlscert-diego-itn-internal-devopslab-pagopa-it.subscription_id
  managed_identity_resource_group_name = local.dev_identity_rg_name

  location                            = var.location_northeurope
  credential_key_vault_name           = data.azurerm_key_vault.domain_kv_dev.name
  credential_key_vault_resource_group = data.azurerm_key_vault.domain_kv_dev.resource_group_name

  variables = merge(
    var.tlscert-diego-itn-internal-devopslab-pagopa-it.pipeline.variables,
    local.tlscert-diego-itn-internal-devopslab-pagopa-it-variables,
  )

  variables_secret = merge(
    var.tlscert-diego-itn-internal-devopslab-pagopa-it.pipeline.variables_secret,
    local.tlscert-diego-itn-internal-devopslab-pagopa-it-variables_secret,
  )

  service_connection_ids_authorization = [
    module.DIEGO-TLS-CERT-SERVICE-CONN.service_endpoint_id,
  ]

  schedules = {
    days_to_build              = ["Tue","Thu","Fri"]
    schedule_only_with_changes = false
    start_hours                = 14
    start_minutes              = 0
    time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = ["master"]
      exclude = []
    }
  }
}
