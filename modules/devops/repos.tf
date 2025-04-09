data "github_repositories" "this" {
  query = "org:${var.org_name} props.has_image:true"
}

data "github_repository_custom_properties" "this" {
  for_each = zipmap(
    data.github_repositories.this.full_names,
    data.github_repositories.this.names
  )
  repository = each.value
}

data "github_repository" "this" {
  for_each = {
    for name, repo in data.github_repository_custom_properties.this : name => repo
    if length([
      for p in repo.property :
      p.property_value if p.property_name == "has_image" && contains(p.property_value, "true")
    ]) > 0
  }
  full_name = each.key
}

resource "duplocloud_aws_ecr_repository" "this" {
  for_each = {
    for name, repo in data.github_repository.this : repo.name => repo
  }
  tenant_id                 = module.tenant.id
  name                      = each.key
  enable_scan_image_on_push = true
  enable_tag_immutability   = false
  force_delete              = false
}

# for gcp
# resource "google_artifact_registry_repository" "this" {
#   for_each      = {
#     for name, repo in data.github_repository.this : repo.name => repo
#   }
#   location      = module.ctx.region
#   repository_id = each.key
#   description   = each.value.description
#   format        = "DOCKER"
# }
