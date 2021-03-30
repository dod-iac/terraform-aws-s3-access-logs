/**
 * ## Usage
 *
 * Creates athena and s3 resources to query s3 access logs
 *
 * * S3 bucket for athena query results
 * * Athena workgroup, database, and named query to create table
 * * Example queries for use against access logs
 *
 * ```hcl
 * module "s3_access_locs" {
 *   source = "dod-iac/s3-access-logs/aws"
 *
 *   target_bucket  = "log-bucket-name"
 *   logging_bucket = "log-bucket-name"
 *
 *   tags = {
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * ## Setup
 *
 * After applying the resources there is one manual step. Run the `create_table` named query to create the table to query against.
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

data "aws_caller_identity" "current" {}

module "aws_s3_bucket_kms_key" {
  source  = "dod-iac/s3-kms-key/aws"
  version = "~> 1.0.1"

  name        = format("alias/%s-key", var.project)
  description = format("S3 KMS key for %s query results", var.project)
  principals  = ["*"]
  tags        = var.tags
}

module "query_results" {
  source  = "trussworks/s3-private-bucket/aws"
  version = "3.4.0"

  bucket                   = replace(format("%s-query-results", var.project), "_", "-")
  enable_analytics         = false
  kms_master_key_id        = module.aws_s3_bucket_kms_key.aws_kms_key_arn
  logging_bucket           = var.logging_bucket
  sse_algorithm            = "aws:kms"
  tags                     = var.tags
  use_account_alias_prefix = false
}

module "athena_workgroup" {
  source = "dod-iac/athena-workgroup/aws"

  encryption_option = "SSE_KMS"
  kms_key_arn       = module.aws_s3_bucket_kms_key.aws_kms_key_arn
  name              = var.project
  output_location   = format("s3://%s/", module.query_results.id)
  tags              = var.tags
}

locals {
  db_name = replace(var.project, "-", "_")
}

resource "aws_athena_database" "access_logs" {
  # https://docs.aws.amazon.com/athena/latest/ug/tables-databases-columns-names.html
  name   = local.db_name
  bucket = module.query_results.id
}
