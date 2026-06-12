subscription_id     = "b6172f60-9a69-46ff-b334-298e40a9d743"
resource_group_name = "Himmat-RG"
location            = "eastus"
environment         = "dev"

# VNet configuration (subnets map to be processed via for_each)
vnet_address_space = ["10.0.0.0/16"]
vnet_subnets = {
  system = {
    name           = "snet-aks-system"
    address_prefix = "10.0.1.0/24"
  }
  user = {
    name           = "snet-aks-user"
    address_prefix = "10.0.2.0/24"
  }
  ingress = {
    name           = "snet-ingress"
    address_prefix = "10.0.3.0/24"
  }
}

# ACR configuration
acr_sku           = "Standard"
acr_admin_enabled = false

# AKS configuration
aks_dns_prefix = "aksstreamflixdev"
aks_system_node_pool = {
  name            = "systempool"
  node_count      = 2
  vm_size         = "Standard_D2s_v5"
  os_disk_size_gb = 50
}
# Map of user node pools to be created via for_each
aks_user_node_pools = {
  app = {
    vm_size              = "Standard_D4s_v5"
    auto_scaling_enabled = true
    min_count            = 2
    max_count            = 10
    node_count           = 2
    os_disk_size_gb      = 100
    node_labels = {
      "pool" = "user"
      "role" = "microservices"
    }
  }
}
aks_network_profile = {
  network_plugin    = "azure"
  network_policy    = "calico"
  load_balancer_sku = "standard"
}

# Key Vault configuration
kv_sku_name                   = "standard"
kv_soft_delete_retention_days = 7
kv_purge_protection_enabled   = false

# SQL Server & Databases configuration (multiple databases to be created via for_each)
sql_admin_username = "sqladmin"
sql_admin_password = "P@ssw0rd12345!" # Overridable secure password
sql_databases = {
  movies = {
    collation      = "SQL_Latin1_General_CP1_CI_AS"
    license_type   = "BasePrice"
    max_size_gb    = 2
    sku_name       = "Basic"
    zone_redundant = false
  }
  users = {
    collation      = "SQL_Latin1_General_CP1_CI_AS"
    license_type   = "BasePrice"
    max_size_gb    = 2
    sku_name       = "Basic"
    zone_redundant = false
  }
}

# Storage configuration
storage_account_tier     = "Standard"
storage_replication_type = "LRS"
storage_min_tls_version  = "TLS1_2"

# Public IP configuration
pip_allocation_method = "Static"
pip_sku               = "Standard"
