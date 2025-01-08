resource "azurerm_kubernetes_cluster" "example" {
  name                = "${module.global.project}${lower(var.env)}"
  location            = module.global.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${module.global.project}${lower(var.env)}"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_A2_v2"
    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = module.environment.tags
}