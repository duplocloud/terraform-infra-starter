terraform {
  required_version = ">= 1.4.4"
  backend "s3" {
    workspace_key_prefix = "tenant"
    key                  = "tenant"
    encrypt              = true
  }
  # backend "gcs" {
  #   prefix = "tenant"
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
    aws = {
      source = "hashicorp/aws"
      version = "5.94.1"
    }
    # google = {
    #   source  = "hashicorp/google"
    #   version = "6.27.0"
    # }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = ">= 2.0.0"
    # }
  }
}
provider "duplocloud" {
}

provider "github" {
  owner = "duplocloud"
  app_auth {
    id              = data.duplocloud_aws_ssm_parameter.github["app_id"].value
    installation_id = data.duplocloud_aws_ssm_parameter.github["installation_id"].value
    pem_file        = data.duplocloud_aws_ssm_parameter.github["pem"].value
  }
}

provider "aws" {
  region     = local.infra.region
  access_key = module.ctx.creds.aws.access_key_id
  secret_key = module.ctx.creds.aws.secret_access_key
  token      = module.ctx.creds.aws.session_token
}

# provider "google" {
#   project = module.ctx.account_id
#   region  = module.ctx.region
# }

# provider "kubernetes" {
#   host                   = module.ctx.creds.k8s.endpoint
#   cluster_ca_certificate = module.ctx.creds.k8s.ca_certificate_data
#   token                  = module.ctx.creds.k8s.token
# }
