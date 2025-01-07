resource azurerm_key_vault akv {
  location                    = module.global.location
  name                       = "tokenrefresh${lower(var.env)}"
  resource_group_name        = azurerm_resource_group.rg.name
  sku_name                   = "standard"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  tags                       = module.environment.tags
}

resource azurerm_role_assignment kv_writers {
  for_each = toset(
    concat(
      [
        data.azurerm_client_config.current.client_id
      ],
      module.environment.kv_writers
    )
  )
  principal_id = each.value
  scope = azurerm_key_vault.akv.id
  role_definition_name = "Key Vault Secrets Officer"
}