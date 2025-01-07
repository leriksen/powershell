resource azurerm_key_vault akv {
  location                    = module.global.location
  name                       = "tokenrefresh"
  resource_group_name        = azurerm_resource_group.rg.name
  sku_name                   = "standard"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  tags                       = module.environment.tags
}