variable "tlscert-dev01-blueprint-internal-devopslab-pagopa-it" {
  default = {
    repository = {
      organization   = "pagopa"
      name           = "le-azure-acme-tiny"
      branch_name    = "refs/heads/master"
      pipelines_path = "."
    }
    pipeline = {
      enable_tls_cert = true
      path            = "TLS-Certificates"
      dns_record_name = "dev01.blueprint.internal"
      dns_zone_name   = "devopslab.pagopa.it"
      # common variables to all pipelines
      variables = {
        CERT_NAME_EXPIRE_SECONDS = "2592000" #30 days
      }
      # common secret variables to all pipelines
      variables_secret = {
      }
    }
  }
}

locals {
  tlscert-dev01-blueprint-internal-devopslab-pagopa-it = {
    tenant_id                           = module.secret_core.values["TENANTID"].value
    subscription_name                   = local.dev_subscription_name
    subscription_id                     = module.secret_core.values["DEV-SUBSCRIPTION-ID"].value
    dns_zone_resource_group             = local.rg_dev_dns_zone_name
    credential_subcription              = local.dev_subscription_name
    credential_key_vault_name           = local.dev_domain_key_vault_name
    credential_key_vault_resource_group = local.dev_domain_key_vault_resource_group
    service_connection_ids_authorization = [
      module.tls_cert_service_conn.service_endpoint_id,
    ]
  }
  tlscert-dev01-blueprint-internal-devopslab-pagopa-it-variables = {
    KEY_VAULT_SERVICE_CONNECTION = module.tls_cert_service_conn.service_endpoint_name,
    KEY_VAULT_NAME               = local.dev_domain_key_vault_name
  }
  tlscert-dev01-blueprint-internal-devopslab-pagopa-it-variables_secret = {
  }
}

# TCE-164-refactor-modulo-tls-cert-con-federated-identity
# change only providers
#tfsec:ignore:general-secrets-no-plaintext-exposure
module "tlscert-dev01-blueprint-internal-devopslab-pagopa-it-cert_az" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert_federated?ref=v4.1.3"
  count  = var.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0

  # change me
  providers = {
    azurerm = azurerm.dev
  }

  project_id = data.azuredevops_project.project.id
  location   = var.location
  repository = var.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.repository
  #tfsec:ignore:general-secrets-no-plaintext-exposure
  #tfsec:ignore:GEN003
  path                         = "${local.domain}\\${var.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.pipeline.path}"
  github_service_connection_id = data.azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id

  dns_record_name         = var.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.pipeline.dns_record_name
  dns_zone_name           = var.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.pipeline.dns_zone_name
  dns_zone_resource_group = local.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.dns_zone_resource_group
  tenant_id               = local.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.tenant_id
  subscription_name       = local.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.subscription_name
  subscription_id         = local.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.subscription_id

  credential_key_vault_name           = local.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.credential_key_vault_name
  credential_key_vault_resource_group = local.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.credential_key_vault_resource_group

  variables = merge(
    var.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.pipeline.variables,
    local.tlscert-dev01-blueprint-internal-devopslab-pagopa-it-variables,
  )

  variables_secret = merge(
    var.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.pipeline.variables_secret,
    local.tlscert-dev01-blueprint-internal-devopslab-pagopa-it-variables_secret,
  )

  service_connection_ids_authorization = local.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.service_connection_ids_authorization

  schedules = {
    days_to_build              = ["Thu"]
    schedule_only_with_changes = false
    start_hours                = 3
    start_minutes              = 0
    time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = [var.tlscert-dev01-blueprint-internal-devopslab-pagopa-it.repository.branch_name]
      exclude = []
    }
  }

  depends_on = [
    module.letsencrypt_dev
  ]
}
