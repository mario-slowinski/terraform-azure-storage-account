variable "share_directories" {
  type = list(object({
    name     = string                # The name (or path) of the Directory that should be created within this File Share.
    share    = string                # The name or id of the File Share where this Directory should be created.
    metadata = optional(map(string)) # A mapping of metadata to assign to this Directory.
  }))
  description = "List of directories within an Azure Storage File Share."
  default     = [{ name = null, share = null }]
}
