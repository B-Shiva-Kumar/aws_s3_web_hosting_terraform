variable "bucket_name" {
    description = "name of the bucket."
    type = string
    # default = "Unique Name"
    default = null
}

variable "bucket_prefix" {
  description = "Prefix for the s3 bucket name. Conflicts with `bucket_name`."
  type        = string
  default     = null
}

variable "bucket_acl" {
    description = "acl permission to access the website domain."
    type = string
    default = "public-read"
}

variable "tags" {
    description = "tags for bucket"
    type = map(string)
    default = {
    Name        = "Web hosting using bucket & terraform modules."
    Environment = "Dev"
  } 
}

variable "documents" {

    description = "Configuration for website files."
    type = object({
        terraform_managed_files = bool                                 // requiered.
        error_document_key    = optional(string, "error.html")         // optional with default value.
        index_document_suffix = optional(string, "index.html")         // optional with default value.
        www_path              = optional(string)                       // optional with no default value so sets to null value. 
    })
}

variable "cors_rules" {
  description = "List of CORS rules."
  type = list(object({
    allowed_headers = optional(set(string)),
    allowed_methods = set(string),
    allowed_origins = set(string),
    expose_headers  = optional(set(string)),
    max_age_seconds = optional(number)
  }))
  default = []
}