variable "containers" {
  type = list(object({
    name                  = string                # The name of the Container which should be created within the Storage Account.
    container_access_type = optional(string)      # The Access Level configured for this Container.
    metadata              = optional(map(string)) # A mapping of MetaData for this Container. All metadata keys should be lowercase.
  }))
  description = "Manages a Container within an Azure Storage Account."
  default     = [{ name = null }]
}
