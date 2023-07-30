output "data" {
  description = "Storage account data."
  value       = azurerm_storage_account.this
  sensitive   = false
}

output "containers" {
  description = "Storage accounts containers."
  value       = azurerm_storage_container.name
  sensitive   = false
}
