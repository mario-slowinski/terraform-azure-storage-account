resource "azurerm_storage_account" "this" {
  access_tier                     = var.access_tier
  account_kind                    = var.account_kind
  account_replication_type        = var.account_replication_type
  account_tier                    = var.account_tier
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  allowed_copy_scope              = var.allowed_copy_scope

  dynamic "azure_files_authentication" {
    for_each = {
      for azure_files_authentication in [var.azure_files_authentication] :
      azure_files_authentication.directory_type => azure_files_authentication
      if azure_files_authentication.directory_type != null
    }
    content {
      directory_type = azure_files_authentication.key
      dynamic "active_directory" {
        for_each = {
          for active_directory in [azure_files_authentication.value.active_directory] :
          active_directory.domain_name => active_directory
          if active_directory.domain_name != null
        }
        content {
          storage_sid         = active_directory.value.storage_sid
          domain_name         = active_directory.value.domain_name
          domain_sid          = active_directory.value.domain_sid
          domain_guid         = active_directory.value.domain_guid
          forest_name         = active_directory.value.forest_name
          netbios_domain_name = active_directory.value.netbios_domain_name
        }
      }
    }
  }

  dynamic "blob_properties" {
    for_each = { for index, blob_properties in [var.blob_properties] : index => blob_properties if blob_properties != null }
    content {
      dynamic "container_delete_retention_policy" {
        for_each = {
          for index, container_delete_retention_policy in [blob_properties.value.container_delete_retention_policy] :
          index => container_delete_retention_policy
          if container_delete_retention_policy != null
        }
        content {
          days = container_delete_retention_policy.value.days
        }
      }
      change_feed_enabled           = blob_properties.value.change_feed_enabled
      change_feed_retention_in_days = blob_properties.value.change_feed_retention_in_days
      dynamic "cors_rule" {
        for_each = {
        for index, cors_rule in [blob_properties.value.cors_rule] : index => cors_rule if cors_rule != null }
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
      default_service_version = blob_properties.value.default_service_version
      dynamic "delete_retention_policy" {
        for_each = { for index, delete_retention_policy in [blob_properties.value.delete_retention_policy] : index => delete_retention_policy if delete_retention_policy != null }
        content {
          days = delete_retention_policy.value.days
        }
      }
      last_access_time_enabled = blob_properties.value.last_access_time_enabled
      dynamic "restore_policy" {
        for_each = { for index, restore_policy in [blob_properties.value.restore_policy] : index => restore_policy if restore_policy != null }
        content {
          days = restore_policy.value.days
        }
      }
      versioning_enabled = blob_properties.value.versioning_enabled
    }
  }

  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled

  dynamic "custom_domain" {
    for_each = { for custom_domain in [var.custom_domain] : custom_domain.name => custom_domain if custom_domain.name != null }
    content {
      name          = custom_domain.value.name
      use_subdomain = custom_domain.value.use_subdomain
    }
  }

  dynamic "customer_managed_key" {
    for_each = { for index, customer_managed_key in [var.customer_managed_key] : index => customer_managed_key if customer_managed_key.key_vault_key_id != null }
    content {
      key_vault_key_id          = customer_managed_key.value.key_vault_key_id
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id
    }
  }

  default_to_oauth_authentication = var.default_to_oauth_authentication
  edge_zone                       = var.edge_zone
  enable_https_traffic_only       = var.enable_https_traffic_only

  dynamic "identity" {
    for_each = { for identity in [var.identity] : identity.type => identity if identity.type != null }
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "immutability_policy" {
    for_each = { for index, immutability_policy in [var.immutability_policy] : index => immutability_policy if immutability_policy.state != null }
    content {
      allow_protected_append_writes = immutability_policy.value.allow_protected_append_writes
      period_since_creation_in_days = immutability_policy.value.period_since_creation_in_days
      state                         = immutability_policy.value.state
    }
  }

  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  is_hns_enabled                    = var.is_hns_enabled
  large_file_share_enabled          = var.large_file_share_enabled
  location                          = var.location
  min_tls_version                   = var.min_tls_version
  name                              = var.name

  dynamic "network_rules" {
    for_each = { for index, network_rules in [var.network_rules] : index => network_rules if network_rules.default_action != null }
    content {
      bypass         = network_rules.value.bypass
      default_action = network_rules.value.default_action
      ip_rules       = network_rules.value.ip_rules
      dynamic "private_link_access" {
        for_each = { for index, private_link_access in [network_rules.value.private_link_access] : index => private_link_access if private_link_access != null }
        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id
          endpoint_tenant_id   = private_link_access.value.endpoint_tenant_id
        }
      }
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
    }
  }

  nfsv3_enabled                 = var.nfsv3_enabled
  public_network_access_enabled = var.public_network_access_enabled
  queue_encryption_key_type     = var.queue_encryption_key_type

  dynamic "queue_properties" {
    for_each = { for index, queue_properties in [var.queue_properties] : index => queue_properties if queue_properties != null }
    content {
      dynamic "cors_rule" {
        for_each = { for index, cors_rule in [var.queue_properties.cors_rule] : index => cors_rule if cors_rule != null }
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
      dynamic "hour_metrics" {
        for_each = { for index, hour_metrics in [var.queue_properties.hour_metrics] : index => hour_metrics if hour_metrics != null }
        content {
          enabled               = hour_metrics.value.enabled
          include_apis          = hour_metrics.value.include_apis
          retention_policy_days = hour_metrics.value.retention_policy_days
          version               = hour_metrics.value.version
        }
      }
      dynamic "minute_metrics" {
        for_each = { for index, minute_metrics in [var.queue_properties.minute_metrics] : index => minute_metrics if minute_metrics != null }
        content {
          enabled               = minute_metrics.value.enabled
          include_apis          = minute_metrics.value.include_apis
          retention_policy_days = minute_metrics.value.retention_policy_days
          version               = minute_metrics.value.version
        }
      }
      dynamic "logging" {
        for_each = { for index, logging in [var.queue_properties.logging] : index => logging if logging != null }
        content {
          delete                = logging.value.delete
          read                  = logging.value.read
          retention_policy_days = logging.value.retention_policy_days
          version               = logging.value.version
          write                 = logging.value.write
        }
      }
    }
  }

  resource_group_name = var.resource_group_name

  dynamic "routing" {
    for_each = { for index, routing in [var.routing] : index => routing if routing != null }
    content {
      publish_internet_endpoints  = routing.value.publish_internet_endpoints
      publish_microsoft_endpoints = routing.value.publish_microsoft_endpoints
      choice                      = routing.value.choice
    }
  }

  dynamic "sas_policy" {
    for_each = { for index, sas_policy in [var.sas_policy] : sas_policy.value.expiration_period => sas_policy if sas_policy.expiration_period != null }
    content {
      expiration_period = sas_policy.value.expiration_period
      expiration_action = sas_policy.value.expiration_action
    }
  }

  dynamic "share_properties" {
    for_each = { for index, share_properties in [var.share_properties] : index => share_properties if share_properties != null }
    content {
      dynamic "cors_rule" {
        for_each = { for index, cors_rule in [var.share_properties.cors_rule] : index => cors_rule if cors_rule != null }
        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
      dynamic "retention_policy" {
        for_each = { for index, retention_policy in [var.share_properties.retention_policy] : index => retention_policy if retention_policy != null }
        content {
          days = retention_policy.value.days
        }
      }
      dynamic "smb" {
        for_each = { for index, smb in [var.share_properties.smb] : index => smb if smb != null }
        content {
          authentication_types            = smb.value.authentication_types
          channel_encryption_type         = smb.value.channel_encryption_type
          kerberos_ticket_encryption_type = smb.value.kerberos_ticket_encryption_type
          multichannel_enabled            = smb.value.multichannel_enabled
          versions                        = smb.value.versions
        }
      }
    }
  }
  shared_access_key_enabled = var.shared_access_key_enabled
  sftp_enabled              = var.sftp_enabled

  dynamic "static_website" {
    for_each = { for index, static_website in [var.static_website] : index => static_website if static_website != null }
    content {
      index_document     = static_website.value.index_document
      error_404_document = static_website.value.error_404_document
    }
  }

  table_encryption_key_type = var.table_encryption_key_type

  tags = merge(local.tags, var.tags)
}
