resource "azurerm_resource_group" "bootstrap" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Random suffix ensures global uniqueness for the storage account name.
# Azure storage account names must be globally unique, 3-24 chars, lowercase letters/numbers only.
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

locals {
  # Keep the storage account name compliant and predictable.
  # "st" + "secplat" + 6 chars = 2 + 6 + 6 = 14 chars (well under 24)
  storage_account_name = "stsecplat${random_string.suffix.result}"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.bootstrap.name
  location                 = azurerm_resource_group.bootstrap.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Security defaults (defensible baseline)
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  shared_access_key_enabled       = true

  # Require HTTPS
  https_traffic_only_enabled = true

  # Turn on soft-delete + versioning (protects state from accidental deletion)
  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }

  tags = var.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.tfstate_container_name
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

resource "azurerm_log_analytics_workspace" "bootstrap" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.bootstrap.location
  resource_group_name = azurerm_resource_group.bootstrap.name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_retention_days

  tags = var.tags
}

