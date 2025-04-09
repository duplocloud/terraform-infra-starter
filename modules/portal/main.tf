locals {
  name = terraform.workspace
}

module "ctx" {
  source  = "duplocloud/components/duplocloud//modules/context"
  version = "0.0.36"
  admin   = true
  tenant  = "default"
}
