resource azurerm_container_registry acr {
  name                = "${module.global.project}${lower(var.env)}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = module.global.location
  sku                 = "Basic"
  tags                = module.environment.tags
}

resource azurerm_role_assignment acr_push {
  principal_id = data.azurerm_client_config.current.object_id
  scope = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"
}