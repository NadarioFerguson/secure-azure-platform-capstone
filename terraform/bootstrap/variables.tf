variable "location" {
  description = "Azure region for bootstrap resources."
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Resource group for bootstrap resources (state, logging, etc.)."
  type        = string
  default     = "rg-secplat-bootstrap"
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default = {
    project    = "secure-azure-platform-capstone"
    owner      = "NadarioFerguson"
    env        = "bootstrap"
    managed_by = "terraform"
  }
}

variable "tfstate_container_name" {
  description = "Blob container name for Terraform state."
  type        = string
  default     = "tfstate"
}

variable "log_analytics_workspace_name" {
  description = "Name for Log Analytics workspace. Must be unique within the resource group."
  type        = string
  default     = "law-secplat-bootstrap"
}

variable "log_analytics_sku" {
  description = "Log Analytics pricing tier."
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_days" {
  description = "Log Analytics retention in days."
  type        = number
  default     = 30
}

