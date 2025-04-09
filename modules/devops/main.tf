locals {
  portal = module.ctx.workspaces.portal
}

module "ctx" {
  source  = "duplocloud/components/duplocloud//modules/context"
  version = "0.0.37"
  admin   = true
  workspaces = {
    portal = {
      name = terraform.workspace
    }
  }
}

module "tenant" {
  source  = "duplocloud/components/duplocloud//modules/tenant"
  version = "0.0.37"
  name    = "devops"
}

# Reads the github credentials created within the portal module
data "duplocloud_aws_ssm_parameter" "github" {
  for_each  = local.portal.github_keys
  tenant_id = local.devops.id
  name      = "/github/${each.key}"
}
