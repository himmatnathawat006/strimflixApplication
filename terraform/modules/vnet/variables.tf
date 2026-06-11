variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "environment" {
  description = "The deployment environment"
  type        = string
}

variable "address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "A map of subnets to create under the virtual network"
  type = map(object({
    name           = string
    address_prefix = string
  }))
}
