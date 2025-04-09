terraform {
  required_version = ">= 1.4.4"

  # for gcp
  # backend "gcs" {
  #   prefix = "portal"
  # }

  # for aws
  backend "s3" {
    key                  = "portal"
    workspace_key_prefix = "portal"
    encrypt              = true
  }
  required_providers {
    duplocloud = {
      source  = "duplocloud/duplocloud"
      version = ">= 0.11.0"
    }
  }
}

# this gets it's creds from DUPLO_HOST and DUPLO_TOKEN
provider "duplocloud" {}
