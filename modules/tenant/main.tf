locals {
  portal_name = "duplocloud"
  infra       = module.ctx.workspaces.infra
  shared      = module.ctx.workspaces.shared
  devops      = module.ctx.workspaces.devops
  portal      = module.ctx.workspaces.portal
}

module "ctx" {
  source  = "duplocloud/components/duplocloud//modules/context"
  version = "0.0.37"
  admin  = true
  jit = {
    aws = true
    k8s = false
  }
  workspaces = {
    portal = {
      name = local.portal_name
    }
    devops = {
      name = local.portal_name
    }
    shared = {
      name = var.shared
    }
    infra = {
      nameRef = {
        workspace = "shared"
        nameKey   = "infra_name"
      }
    }
  }
}

# get the github credentials from secrets manager
data "duplocloud_aws_ssm_parameter" "github" {
  for_each  = local.portal.github_keys
  tenant_id = local.portal.tenant.id
  name      = "/github/${each.key}"
}
