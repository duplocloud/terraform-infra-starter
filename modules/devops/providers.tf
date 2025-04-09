terraform {
  required_version = ">= 1.4.4"
  backend "s3" {
    workspace_key_prefix = "portal"
    key                  = "devops"
    encrypt              = true
  }
  # backend "gcs" {
  #   prefix = "devops"
  # }
  required_providers {
    duplocloud = {
      source  = "duplocloud/duplocloud"
      version = ">= 0.11.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
    # google = {
    #   source  = "hashicorp/google"
    #   version = "6.27.0"
    # }
  }
}

provider "duplocloud" {
}

provider "github" {
  owner = var.org_name
  app_auth {
    id              = data.duplocloud_aws_ssm_parameter.github["app_id"].value
    installation_id = data.duplocloud_aws_ssm_parameter.github["installation_id"].value
    pem_file        = data.duplocloud_aws_ssm_parameter.github["pem"].value
  }
}

# provider "google" {
#   project = module.ctx.account_id
#   region  = module.ctx.region
# }
