output "data" {
  description = "Storage account data."
  value       = azurerm_storage_account.this
  sensitive   = false
}
