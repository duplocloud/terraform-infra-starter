module "nodegroup" {
  source             = "duplocloud/components/duplocloud//modules/eks-nodes"
  version            = "0.0.37"
  prefix             = "apps-"
  tenant_id          = module.tenant.id
  capacity           = var.asg.capacity
  eks_version        = local.infra.settings.K8sVersion
  instance_count     = var.asg.instance_count
  min_instance_count = var.asg.min_instance_count
  max_instance_count = var.asg.max_instance_count
  os_disk_size       = var.asg.os_disk_size
  minion_tags = {
    "AllocationTags" = "shared"
  }
}

