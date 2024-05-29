variable "tlscert-testit-itn-internal-devopslab-pagopa-it" {
  default = {
    repository = {
      organization   = "pagopa"
      name           = "le-azure-acme-tiny"
      branch_name    = "refs/heads/master"
      pipelines_path = "."
    }
    pipeline = {
      enable_tls_cert = true
      path            = "TLS-Certificates\\DEV"
      dns_record_name = "testit.itn.internal"
      dns_zone_name   = "devopslab.pagopa.it"
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
  tlscert-testit-itn-internal-devopslab-pagopa-it = {
    tenant_id         = data.azurerm_client_config.current.tenant_id
    subscription_name = data.azurerm_subscriptions.dev.subscriptions[0].display_name
    subscription_id   = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
  }
  tlscert-testit-itn-internal-devopslab-pagopa-it-variables = {
    KEY_VAULT_SERVICE_CONNECTION = module.DEV-PRINTIT-TLS-CERT-SERVICE-CONN.service_endpoint_name,
  }
  tlscert-testit-itn-internal-devopslab-pagopa-it-variables_secret = {
  }
}

module "tlscert-testit-itn-internal-devopslab-pagopa-it-cert_az" {

  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert_federated?ref=fix-cert-pipeline-definition"
  count  = var.tlscert-testit-itn-internal-devopslab-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0
  providers = {
    azurerm = azurerm.dev
  }

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.tlscert-testit-itn-internal-devopslab-pagopa-it.repository
  path                         = var.tlscert-testit-itn-internal-devopslab-pagopa-it.pipeline.path
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.id

  dns_record_name                      = var.tlscert-testit-itn-internal-devopslab-pagopa-it.pipeline.dns_record_name
  dns_zone_name                        = var.tlscert-testit-itn-internal-devopslab-pagopa-it.pipeline.dns_zone_name
  dns_zone_resource_group              = var.internal_devopslab_dns_private_rg_name
  tenant_id                            = local.tlscert-testit-itn-internal-devopslab-pagopa-it.tenant_id
  subscription_name                    = local.tlscert-testit-itn-internal-devopslab-pagopa-it.subscription_name
  subscription_id                      = local.tlscert-testit-itn-internal-devopslab-pagopa-it.subscription_id
  managed_identity_resource_group_name = var.identity_rg_name

  credential_key_vault_name           = local.dev_domain_key_vault_name
  credential_key_vault_resource_group = local.dev_domain_key_vault_resource_group
  location                            = var.location

  variables = merge(
    var.tlscert-testit-itn-internal-devopslab-pagopa-it.pipeline.variables,
    local.tlscert-testit-itn-internal-devopslab-pagopa-it-variables,
  )

  variables_secret = merge(
    var.tlscert-testit-itn-internal-devopslab-pagopa-it.pipeline.variables_secret,
    local.tlscert-testit-itn-internal-devopslab-pagopa-it-variables_secret,
  )

  service_connection_ids_authorization = [
    module.DEV-PRINTIT-TLS-CERT-SERVICE-CONN.service_endpoint_id,
  ]

  schedules = {
    days_to_build              = ["Fri"]
    schedule_only_with_changes = false
    start_hours                = 3
    start_minutes              = 0
    time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = ["master"]
      exclude = []
    }
  }
}
