variable "vpc_config" {
  description = "To get the CIDR block and name of the VPC from user"
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR Format - ${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
  description = "To get the CIDR block and AZ for the Subnet from user"
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)
  }))

  validation {
    condition = alltrue([
      for subnet in var.subnet_config : can(cidrnetmask(subnet.cidr_block))
    ])
    error_message = "Invalid CIDR Format in Subnet Configuration"
  }
}

