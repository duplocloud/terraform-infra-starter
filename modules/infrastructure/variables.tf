variable "region" {
  description = "The region to place the infrastructure in. Defaults to portals region."
  type        = string
  nullable    = true
  default     = null
}

variable "azcount" {
  description = "The number of availability zones to use"
  type        = number
  default     = 2
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "cert" {
  description = "The default cert to use for infrastructures"
  type = object({
    name = string
    arn  = string
  })
  default = {
    name = ""
    arn  = ""
  }
}
