output "infra_name" {
  description = "The name of the infrastructure for the shared environment"
  value       = var.infra
}

output "name" {
  description = "The tenant name"
  value       = module.tenant.name
}

output "id" {
  description = "The tenant id"
  value       = module.tenant.id
}
