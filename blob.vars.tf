variable "blobs" {
  type = list(object({
    name                   = string                # The name of the storage blob. Must be unique within the storage container the blob is located.
    storage_container_name = string                # The name of the storage container in which this blob should be created.
    type                   = string                # The type of the storage blob to be created.
    size                   = optional(number)      # Used only for page blobs to specify the size in bytes of the blob to be created. Must be a multiple of 512.
    access_tier            = optional(string)      # The access tier of the storage blob. Possible values are Archive, Cool and Hot.
    cache_control          = optional(string)      # Controls the cache control header content of the response when blob is requested.
    content_type           = optional(string)      # The content type of the storage blob. Cannot be defined if source_uri is defined. Defaults to application/octet-stream.
    content_md5            = optional(string)      # The MD5 sum of the blob contents. Cannot be defined if source_uri is defined, or if blob type is Append or Page.
    source                 = optional(string)      # An absolute path to a file on the local system. This field cannot be specified for Append blobs and cannot be specified if source_content or source_uri is specified.
    source_content         = optional(string)      # The content for this blob which should be defined inline. This field can only be specified for Block blobs and cannot be specified if source or source_uri is specified.
    source_uri             = optional(string)      # The URI of an existing blob, or a file in the Azure File service, to use as the source contents for the blob to be created.
    parallelism            = optional(number)      # The number of workers per CPU core to run for concurrent uploads. Defaults to 8.
    metadata               = optional(map(string)) # A map of custom blob metadata.
  }))
  description = "Manages a Blob within a Storage Container."
  default     = [{ name = null, storage_container_name = null, type = null }]
}
