module "ctx" {
  source  = "duplocloud/components/duplocloud//modules/context"
  version = "0.0.37"
  admin   = true
  workspaces = {
    portal = {
      name = "duplocloud"
    }
  }
}
