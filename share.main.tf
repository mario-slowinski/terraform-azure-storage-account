resource "azurerm_storage_share" "name" {
  for_each = { for share in var.shares : share.name => share if share.name != null }

  name                 = each.key
  storage_account_name = coalesce(each.value.storage_account_name, var.name)
  access_tier          = each.value.access_tier
  dynamic "acl" {
    for_each = { for acl in [each.value.acl] : acl.id => acl if acl != null }
    content {
      id = acl.value.id
      dynamic "access_policy" {
        for_each = { for index, access_policy in [acl.value.access_policy] : index => access_policy if acl.value.access_policy != null }
        content {
          permissions = access_policy.value.permissions
          start       = access_policy.value.start
          expiry      = access_policy.value.expiry
        }
      }
    }
  }
  enabled_protocol = each.value.enabled_protocol
  quota            = each.value.quota
  metadata         = each.value.metadata

  depends_on = [
    azurerm_storage_account.this,
  ]
}
