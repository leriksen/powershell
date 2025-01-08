resource azurerm_resource_group rg {
  name = "${module.global.project}${ var.env }"
  location = module.global.location
  tags = module.environment.tags
}