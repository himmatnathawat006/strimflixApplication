resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-streamflix-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name            = var.system_node_pool.name
    node_count      = var.system_node_pool.node_count
    vm_size         = var.system_node_pool.vm_size
    vnet_subnet_id  = var.vnet_subnet_id
    type            = "VirtualMachineScaleSets"
    os_disk_size_gb = var.system_node_pool.os_disk_size_gb

    node_labels = {
      "pool" = "system"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = var.network_profile.network_plugin
    network_policy    = var.network_profile.network_policy
    load_balancer_sku = var.network_profile.load_balancer_sku
    service_cidr      = "10.244.0.0/16"
    dns_service_ip    = "10.244.0.10"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  tags = {
    Environment = var.environment
    Project     = "StreamFlix"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "user_pools" {
  for_each              = var.user_node_pools
  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size
  vnet_subnet_id        = var.vnet_subnet_id

  auto_scaling_enabled = each.value.auto_scaling_enabled
  min_count            = each.value.min_count
  max_count            = each.value.max_count
  node_count           = each.value.node_count

  os_disk_size_gb = each.value.os_disk_size_gb

  node_labels = each.value.node_labels

  tags = {
    Environment = var.environment
    Project     = "StreamFlix"
  }
}
