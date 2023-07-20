variable "access_tier" {
  type        = string
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts."
  default     = "Hot"
  validation {
    condition = contains([
      "Hot",
      "Cool",
      ],
    var.access_tier)
    error_message = "Valid options are Hot and Cool."
  }
}

variable "account_kind" {
  type        = string
  description = "(Optional) Defines the Kind of account."
  default     = "StorageV2"
  validation {
    condition = contains([
      "BlobStorage",
      "BlockBlobStorage",
      "FileStorage",
      "Storage",
      "StorageV2",
      ],
    var.account_kind)
    error_message = "Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  }
}

variable "account_replication_type" {
  type        = string
  description = "(Required) Defines the type of replication to use for this storage account."
  default     = ""
  validation {
    condition = contains([
      "LRS",
      "GRS",
      "RAGRS",
      "ZRS",
      "GZRS",
      "RAGZRS",
      ],
    var.account_replication_type)
    error_message = "Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  }
}

variable "account_tier" {
  type        = string
  description = "(Required) Defines the Tier to use for this storage account."
  default     = ""
  validation {
    condition = contains([
      "Standard",
      "Premium",
      ],
    var.account_tier)
    error_message = "Valid options are Standard and Premium."
  }
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "(Optional) Allow or disallow nested items within this Account to opt into being public."
  default     = null
}

variable "allowed_copy_scope" {
  type        = string
  description = "(Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet."
  default     = null
}

variable "azure_files_authentication" {
  type = object({
    directory_type = string # Specifies the directory service used. Possible values are AADDS, AD and AADKERB.
    active_directory = optional(object({
      storage_sid         = string # Specifies the security identifier (SID) for Azure Storage.
      domain_name         = string # Specifies the primary domain that the AD DNS server is authoritative for.
      domain_sid          = string # Specifies the security identifier (SID).
      domain_guid         = string # Specifies the domain GUID.
      forest_name         = string # Specifies the Active Directory forest.
      netbios_domain_name = string # Specifies the NetBIOS domain name.
    }))
  })
  description = "(Optional) A azure_files_authentication block."
  default     = { directory_type = null }
}

variable "blob_properties" {
  type = object({
    container_delete_retention_policy = optional(object({
      days = optional(number) # Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
    }))
    change_feed_enabled           = optional(bool)   # Is the blob service properties for change feed events enabled?
    change_feed_retention_in_days = optional(string) # The duration of change feed events retention in days.
    cors_rule = optional(object({
      allowed_headers    = list(string) # A list of headers that are allowed to be a part of the cross-origin request.
      allowed_methods    = list(string) # A list of HTTP methods that are allowed to be executed by the origin.
      allowed_origins    = list(string) # A list of origin domains that will be allowed by CORS.
      exposed_headers    = list(string) # A list of response headers that are exposed to CORS clients.
      max_age_in_seconds = number       # The number of seconds the client should cache a preflight response.
    }))
    default_service_version = optional(string) # The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version.
    delete_retention_policy = optional(object({
      days = optional(number) # Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7.
    }))
    last_access_time_enabled = optional(bool) # Is the last access time based tracking enabled?
    restore_policy = optional(object({
      days = optional(number) # Specifies the number of days that the blob can be restored, between 1 and 365 days.
    }))
    versioning_enabled = optional(bool) # Is versioning enabled?
  })
  description = "(Optional) A blob_properties block."
  default     = null
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  description = "(Optional) Should cross Tenant replication be enabled?"
  default     = null
}

variable "custom_domain" {
  type = object({
    name          = string         # The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
    use_subdomain = optional(bool) # Should the Custom Domain Name be validated by using indirect CNAME validation?
  })
  description = "(Optional) A custom_domain block."
  default     = { name = null }
}

variable "customer_managed_key" {
  type = object({
    key_vault_key_id          = string # The ID of the Key Vault Key, supplying a version-less key ID will enable auto-rotation of this key.
    user_assigned_identity_id = string # The ID of a user assigned identity.
  })
  description = "(Optional) A customer_managed_key block."
  default     = { key_vault_key_id = null, user_assigned_identity_id = null }
}

variable "default_to_oauth_authentication" {
  type        = bool
  description = "(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account."
  default     = null
}

variable "edge_zone" {
  type        = string
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist."
  default     = null
}

variable "enable_https_traffic_only" {
  type        = bool
  description = "(Optional) Boolean flag which forces HTTPS if enabled, see here for more information."
  default     = null
}

variable "identity" {
  type = object({
    type         = string                 # Specifies the type of Managed Service Identity that should be configured on this Storage Account.
    identity_ids = optional(list(string)) # Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account.
  })
  description = "(Optional) A identity block."
  default     = { type = null }
}

variable "immutability_policy" {
  type = object({
    allow_protected_append_writes = bool   # When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance.
    period_since_creation_in_days = number # The immutability period for the blobs in the container since the policy creation, in days.
    state                         = string # Defines the mode of the policy.
  })
  description = "(Optional) An immutability_policy block."
  default = {
    allow_protected_append_writes = null
    period_since_creation_in_days = null
    state                         = null
  }
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  description = "(Optional) Is infrastructure encryption enabled?"
  default     = null
}

variable "is_hns_enabled" {
  type        = bool
  description = "(Optional) Is Hierarchical Namespace enabled?"
  default     = null
}

variable "large_file_share_enabled" {
  type        = bool
  description = "(Optional) Is Large File Share Enabled?"
  default     = null
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists."
  default     = null
}

variable "min_tls_version" {
  type        = string
  description = "(Optional) The minimum supported TLS version for the storage account."
  default     = null
}

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed."
  default     = null
}

variable "network_rules" {
  type = object({
    bypass         = optional(string)            # Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
    default_action = string                      # Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow.
    ip_rules       = optional(list(string))      # List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed.
    private_link_access = optional(list(object({ # One or More private_link_access block
      endpoint_resource_id = string              # The resource id of the resource access rule to be granted access.
      endpoint_tenant_id   = optional(string)    # The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id.
    })))
    virtual_network_subnet_ids = optional(list(string)) # A list of resource ids for subnets.
  })
  description = "(Optional) A network_rules block."
  default     = { default_action = null }
}

variable "nfsv3_enabled" {
  type        = bool
  description = "(Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created."
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether the public network access is enabled?"
  default     = null
}

variable "queue_encryption_key_type" {
  type        = string
  description = "(Optional) The encryption type of the queue service."
  default     = null
}

variable "queue_properties" {
  type = object({
    cors_rule = optional(object({
      allowed_headers    = list(string) # A list of headers that are allowed to be a part of the cross-origin request.
      allowed_methods    = list(string) # A list of HTTP methods that are allowed to be executed by the origin.
      allowed_origins    = list(string) # A list of origin domains that will be allowed by CORS.
      exposed_headers    = list(string) # A list of response headers that are exposed to CORS clients.
      max_age_in_seconds = number       # The number of seconds the client should cache a preflight response.
    }))
    hour_metrics = optional(object({
      enabled               = bool             # Indicates whether hour metrics are enabled for the Queue service.
      include_apis          = optional(bool)   # Indicates whether metrics should generate summary statistics for called API operations.
      retention_policy_days = optional(number) # Specifies the number of days that logs will be retained.
      version               = string           # The version of storage analytics to configure.
    }))
    minute_metrics = optional(object({
      enabled               = bool             # Indicates whether hour metrics are enabled for the Queue service.
      include_apis          = optional(bool)   # Indicates whether metrics should generate summary statistics for called API operations.
      retention_policy_days = optional(number) # Specifies the number of days that logs will be retained.
      version               = string           # The version of storage analytics to configure.
    }))
    logging = optional(object({
      delete                = bool             # Indicates whether all delete requests should be logged.
      read                  = bool             # Indicates whether all read requests should be logged.
      retention_policy_days = optional(number) # Specifies the number of days that logs will be retained.
      version               = string           # The version of storage analytics to configure.
      write                 = bool             # Indicates whether all write requests should be logged.
    }))
  })
  description = "(Optional) A queue_properties block."
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the storage account."
  default     = null
}

variable "routing" {
  type = object({
    publish_internet_endpoints  = optional(bool)   # Should internet routing storage endpoints be published?
    publish_microsoft_endpoints = optional(bool)   # Should Microsoft routing storage endpoints be published? Defaults to false.
    choice                      = optional(string) # Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting.
  })
  description = "(Optional) A routing block."
  default     = null
}

variable "sas_policy" {
  type = object({
    expiration_period = string           # The SAS expiration period in format of DD.HH:MM:SS.
    expiration_action = optional(string) # The SAS expiration action.
  })
  description = "(Optional) A sas_policy block."
  default     = { expiration_period = null }
}

variable "share_properties" {
  type = object({
    cors_rule = optional(object({
      allowed_headers    = list(string) # A list of headers that are allowed to be a part of the cross-origin request.
      allowed_methods    = list(string) # A list of HTTP methods that are allowed to be executed by the origin.
      allowed_origins    = list(string) # A list of origin domains that will be allowed by CORS.
      exposed_headers    = list(string) # A list of response headers that are exposed to CORS clients.
      max_age_in_seconds = number       # The number of seconds the client should cache a preflight response.
    }))
    retention_policy = optional(object({
      days = optional(number) # Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 7.
    }))
    smb = optional(object({
      authentication_types            = optional(string) # A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
      channel_encryption_type         = optional(string) # A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
      kerberos_ticket_encryption_type = optional(string) # A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
      multichannel_enabled            = optional(bool)   # Indicates whether multichannel is enabled.
      versions                        = optional(string) # A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
    }))
  })
  description = "(Optional) A share_properties block."
  default     = null
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "(Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  default     = null
}

variable "sftp_enabled" {
  type        = bool
  description = "(Optional) Enable SFTP for the storage account?"
  default     = null
}

variable "static_website" {
  type = object({
    index_document     = optional(string) # The webpage that Azure Storage serves for requests to the root of a website or any subfolder.
    error_404_document = optional(string) # The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
  })
  description = "(Optional) A static_website block."
  default     = null
}

variable "table_encryption_key_type" {
  type        = string
  description = "(Optional) The encryption type of the table service."
  default     = null
}
