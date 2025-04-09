locals {
  infra  = module.ctx.workspaces.infrastructure
  portal = module.ctx.workspaces.portal
}

module "ctx" {
  source  = "duplocloud/components/duplocloud//modules/context"
  version = "0.0.37"
  admin  = true
  workspaces = {
    portal = {
      name = "duplocloud"
    }
    infrastructure = {
      name = var.infra
    }
  }
}
