terraform {
  required_version = ">= 1.4.4"
  backend "s3" {
    workspace_key_prefix = "infra"
    key                  = "shared"
    encrypt              = true
  }
  # backend "gcs" {
  #   prefix = "shared"
  # }
  required_providers {
    duplocloud = {
      source  = "duplocloud/duplocloud"
      version = ">= 0.11.0"
    }
  }
}
provider "duplocloud" {
}
