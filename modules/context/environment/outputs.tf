output "tags" {
  value = merge(
    module.subscription.tags,
    {
      environment = var.environment
    }
  )
}

output "env_sub" {
  value = local.env_sub[var.environment]
}

output "kv_writers" {
  value = local.kv_writers[var.environment]
}

output "acr_pushers" {
  value = local.acr_pushers[var.environment]
}
