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

variable "vnet_subnet_id" {
  description = "The subnet ID for the AKS nodes"
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
}

variable "system_node_pool" {
  description = "The configuration of the default system node pool"
  type = object({
    name            = string
    node_count      = number
    vm_size         = string
    os_disk_size_gb = number
  })
}

variable "user_node_pools" {
  description = "A map of user node pools to attach to the AKS cluster"
  type = map(object({
    vm_size              = string
    auto_scaling_enabled = bool
    min_count            = number
    max_count            = number
    node_count           = number
    os_disk_size_gb      = number
    node_labels          = map(string)
  }))
}

variable "network_profile" {
  description = "The network configuration profile for the AKS cluster"
  type = object({
    network_plugin    = string
    network_policy    = string
    load_balancer_sku = string
  })
}
