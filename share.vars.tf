variable "shares" {
  type = list(object({
    name                 = string           #  The name of the share. Must be unique within the storage account where the share is located.
    storage_account_name = optional(string) # Specifies the storage account in which to create the share. Changing this forces a new resource to be created.
    access_tier          = optional(string) # The access tier of the File Share. Possible values are Hot, Cool and TransactionOptimized, Premium.
    acl = optional(object({
      id = string # The ID which should be used for this Shared Identifier.
      access_policy = optional(object({
        permissions = string           # The permissions which should be associated with this Shared Identifier. Possible value is combination of r (read), w (write), d (delete), and l (list).
        start       = optional(string) # The time at which this Access Policy should be valid from, in ISO8601 format.
        expiry      = optional(string) # The time at which this Access Policy should be valid until, in ISO8601 format.
      }))
    }))
    enabled_protocol = optional(string)      # The protocol used for the share. Possible values are SMB and NFS.
    quota            = number                # The maximum size of the share, in gigabytes.
    metadata         = optional(map(string)) # A mapping of MetaData for this File Share.
  }))
  description = "Manages a File Share within Azure Storage."
  default     = [{ name = null, quota = null }]
}
