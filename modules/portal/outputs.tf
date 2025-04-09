output "name" {
  value       = local.name
  description = "The name of the infrastructure"
}

output "ctx" {
  value       = module.ctx.system
  description = "The context module"
}

output "cloud" {
  value       = module.ctx.cloud
  description = "The cloud provider"
}

output "region" {
  value       = module.ctx.default_region
  description = "The region"
}

output "account_id" {
  value       = module.ctx.account_id
  description = "The account id for aws or the project id for gcp."
}

output "infra" {
  value       = module.ctx.infra
  description = "The default infrastructure"
}

output "tenant" {
  value       = module.ctx.tenant
  description = "The default tenant"
}

output "github_keys" {
  value       = toset(keys(module.github_creds))
  description = "The keys for the github app secret"
}
