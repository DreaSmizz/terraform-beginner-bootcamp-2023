variable "user_uuid" {
  description = "User UUID"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}

#variable "bucket_name" {
#  description = "AWS S3 Bucket Name"
#  type        = string

#  validation {
#    condition     = can(regex("^[a-zA-Z0-9.-]{3,63}$", var.bucket_name))
#    error_message = "Bucket name must be 3-63 characters long and only contain letters, numbers, hyphens, and periods."
#  }
#}

variable "public_path" {
  description = "The file path for the public directory"
  type = string

#  validation {
#    condition = fileexists(var.index_html_filepath)
#    error_message = "The provided path for index.html does not exist."
#  }
}

#variable "error_html_filepath" {
#  description = "The file path for error.html"
#  type = string

#  validation {
#    condition = fileexists(var.error_html_filepath)
#    error_message = "The provided path for error.html does not exist."
#  }
#}

variable "content_version" {
  description = "Content Version (Positive Integer)"
  type        = number

  validation {
    condition     = var.content_version >= 1 && ceil(var.content_version) == var.content_version
    error_message = "Content version must be a positive integer starting at 1."
  }
}

#variable "assets_path" {
#  description = "The file path for assets"
#  type = string
#}