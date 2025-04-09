module "tenant" {
  source     = "duplocloud/components/duplocloud//modules/tenant"
  version    = "0.0.37"
  infra_name = var.infra
  settings = {
    enable_host_other_tenants = "true"
    delete_protection         = "true"
  }
}
