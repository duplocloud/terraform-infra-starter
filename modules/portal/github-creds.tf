# This is all happening before anything else is created
# we just need the github credentials once per portal and the default tenant 
# is the one that is created first, it's where we can save these creds
# this only initializes the secret, someone needs to manually input the actual variables
module "github_creds" {
  for_each = toset([
    "app_id",
    "installation_id",
    "pem"
  ])
  source    = "duplocloud/components/duplocloud//modules/configuration"
  version   = "0.0.36"
  tenant_id = module.ctx.tenant.id
  class     = "aws-ssm-secure"
  managed   = false # tf will ignore the value, ie it won't get overwritten
  name      = "/github/${each.key}"
  value     = "add me after i'm created"
}
