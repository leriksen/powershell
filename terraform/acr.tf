resource azurerm_container_registry acr {
  name                = "${module.global.project}${lower(var.env)}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = module.global.location
  sku                 = "Basic"
  tags                = module.environment.tags
}

resource azurerm_role_assignment acr_push {
  for_each = toset(
    concat(
      [
        data.azurerm_client_config.current.object_id
      ],
      module.environment.acr_pushers
    )
  )
  principal_id = each.value
  scope = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"
}