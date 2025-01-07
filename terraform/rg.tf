resource azurerm_resource_group rg {
  name = "token-refresh-${ var.env }"
  location = module.global.location
  tags = module.environment.tags
}