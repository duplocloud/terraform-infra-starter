variable "infra" {
  description = "The name of an infrastructure to use."
  type        = string
  default     = "nonprod01"
}

variable "asg" {
  type = object({
    az_count           = optional(number, 1)
    capacity           = optional(string, "t3.medium")
    instance_count     = optional(number, 1)
    min_instance_count = optional(number, 0)
    max_instance_count = optional(number, 10)
    os_disk_size       = optional(number, 40)
  })
  default     = {}
  description = "Configure the hosts for apps."
}
