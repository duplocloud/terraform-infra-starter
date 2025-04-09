output "name" {
  description = "The name of the tenant."
  value       = module.tenant.name
}

output "id" {
  description = "The tenant id"
  value       = module.tenant.id
}

output "portal" {
  description = "The portal name"
  value       = local.portal
}

output "devops" {
  description = "The portal name"
  value = merge(local.devops, {
    repos = {
      for name, repo in local.devops.repos : name => merge(repo, {})
    }
  })
}

output "infra" {
  description = "The infra name"
  value       = local.infra
}

output "shared" {
  description = "The shared tenant name"
  value       = local.shared
}
