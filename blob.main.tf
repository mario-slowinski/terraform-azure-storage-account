resource "azurerm_storage_blob" "name" {
  for_each = { for blob in var.blobs : blob.name => blob if blob.name != null }

  name                   = each.key
  storage_account_name   = var.name
  storage_container_name = each.value.storage_container_name
  type                   = each.value.type
  size                   = each.value.size
  access_tier            = each.value.access_tier
  cache_control          = each.value.cache_control
  content_type           = each.value.content_type
  content_md5            = each.value.content_md5
  source                 = each.value.source
  source_content         = each.value.source_content
  source_uri             = each.value.source_uri
  parallelism            = each.value.parallelism
  metadata               = each.value.metadata
}
