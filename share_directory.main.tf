resource "azurerm_storage_share_directory" "share__name" {
  for_each = {
    for share_directory in var.share_directories :
    "${share_directory.share_name}__${share_directory.name}" => share_directory
    if share_directory.name != null
  }

  name                 = each.value.name
  share_name           = each.value.share_name
  storage_account_name = coalesce(each.value.storage_account_name, var.name)
  metadata             = each.value.metadata

  depends_on = [
    azurerm_storage_share.name,
  ]
}
