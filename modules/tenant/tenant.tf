module "tenant" {
  source  = "duplocloud/components/duplocloud//modules/tenant-gh"
  version = "0.0.37"
  parent = var.shared
  repos  = keys(local.devops.repos)
  settings = {
    enable_service_on_any_host = "true"
    delete_protection          = "true"
  }
}
