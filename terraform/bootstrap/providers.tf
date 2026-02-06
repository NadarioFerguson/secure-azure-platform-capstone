provider "azurerm" {
  features {}

  # Intentionally do NOT hardcode subscription/tenant here.
  # Use environment variables locally and OIDC in CI/CD.
}

provider "azuread" {
  # Same principle: auth via Azure CLI locally, OIDC in CI/CD.
}

# Use random for globally-unique names (e.g., storage account for remote state)
provider "random" {}

