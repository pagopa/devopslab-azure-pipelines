data "azurerm_client_config" "current" {}

data "azurerm_subscriptions" "dev" {
  display_name_prefix = local.dev_subscription_name
}
