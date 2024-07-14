resource "azurerm_storage_share_directory" "share__directory" {
  for_each = {
    for share_directory in var.share_directories :
    "${share_directory.share}__${share_directory.name}" => share_directory
    if share_directory.name != null
  }

  name = each.value.name
  storage_share_id = startswith(each.value.share, "https://") ? (
    each.value.share
    ) : (
    azurerm_storage_share.name[each.value.share].id
  )
  metadata = each.value.metadata
}
