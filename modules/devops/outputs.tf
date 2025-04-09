output "name" {
  description = "The name of the project"
  value       = module.tenant.name
}

output "id" {
  description = "The tenant id"
  value       = module.tenant.id
}

output "repos" {
  description = "Info about all the repos with the repository_url"
  value = {
    for full_name, repo in data.github_repository.this : repo.name => {
      github   = repo
      registry = duplocloud_aws_ecr_repository.this[repo.name]
      # registry = google_artifact_registry_repository.this[repo.name]
    }
  }
}
