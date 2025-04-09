terraform {
  required_version = ">= 1.4.4"
  backend "gcs" {
    prefix = "infrastructure"
  }
  required_providers {
    duplocloud = {
      source  = "duplocloud/duplocloud"
      version = ">= 0.11.0"
    }
  }
}

provider "duplocloud" {
}
