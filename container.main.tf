resource "azurerm_storage_container" "name" {
  for_each = {
    for name, container in var.containers :
    coalesce(container.name, name) => container
    if container.name != null
  }

  container_access_type = each.value.container_access_type
  metadata              = each.value.metadata
  name                  = each.key
  storage_account_name  = var.name
}
