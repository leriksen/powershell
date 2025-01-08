resource "azurerm_kubernetes_cluster" "example" {
  name                = "${module.global.project}${lower(var.env)}"
  location            = module.global.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${module.global.project}${lower(var.env)}"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_A2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = module.environment.tags
}