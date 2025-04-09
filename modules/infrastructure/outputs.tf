output "name" {
  description = "The name of the infrastructure"
  value       = module.infra.name
}

output "region" {
  description = "The region the infrastructure is deployed in"
  value       = module.infra.region
}

output "cert" {
  description = "The default cert to use for infrastructure."
  value       = var.cert
}

output "vpc" {
  description = "The VPC of the infrastructure"
  value       = module.infra.vpc
}

output "settings" {
  description = "The settings of the infrastructure"
  value       = module.infra.settings
}
