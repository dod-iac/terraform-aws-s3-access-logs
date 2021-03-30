
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

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources"
  default = {
    Automation = "Terraform"
  }
}
