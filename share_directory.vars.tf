variable "share_directories" {
  type = list(object({
    name                 = string                # The name (or path) of the Directory that should be created within this File Share.
    share_name           = string                # The name of the File Share where this Directory should be created.
    storage_account_name = optional(string)      # The name of the Storage Account within which the File Share is located.
    metadata             = optional(map(string)) # A mapping of metadata to assign to this Directory.
  }))
  description = "List of directories within an Azure Storage File Share."
  default     = [{ name = null, share_name = null }]
}
