module "infra" {
  source         = "duplocloud/components/duplocloud//modules/infrastructure"
  version        = "0.0.37"
  class          = "k8s"
  account        = module.ctx.account_id
  region         = coalesce(var.region, module.ctx.default_region)
  address_prefix = var.cidr
  azcount        = var.azcount
  settings = {
    EnableAwsAlbIngress     = "true"
    EnableClusterAutoscaler = "true"
    EnableSecretCsiDriver   = "true"
  }
  certificates = {
    (var.cert.name) = var.cert.arn
  }
}
