
variable "project" {
  type        = string
  default     = "s3-access-logs"
  description = "Unique name for the set of logs being analyzed"
}

variable "logging_bucket" {
  type        = string
  description = "The S3 bucket to send logs for query results bucket"
}

variable "target_bucket" {
  type        = string
  description = "The S3 bucket to target for s3 access logs."
}

variable "target_prefix" {
  type        = string
  default     = "s3"
  description = "The S3 prefix to target for s3 access logs"
}

variable "bytes_scanned_cutoff_per_query" {
  type        = number
  description = "Integer for the upper data usage limit (cutoff) for the amount of bytes a single query in a workgroup is allowed to scan. Must be at least 10485760."
  default     = -1
}

variable "database_name" {
  type        = string
  description = "The name of an existing database. If none exists then a new athena database will be created."
  default     = ""
}

variable "table_name" {
  type        = string
  description = "The name of an existing table. If none exists then a new athena database will be created."
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources"
  default = {
    Automation = "Terraform"
  }
}
