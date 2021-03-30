
# Queries copied from https://aws.amazon.com/premiumsupport/knowledge-center/analyze-logs-athena/

locals {
  queries = [
    "actions_by_user",
    "create_table",
    "log_deleted_object",
    "operations_on_object",
    "show_data_transfer_by_ip",
    "who_deleted_object",
  ]
}

data "template_file" "query" {
  count = length(local.queries)

  template = file("${path.module}/query_templates/${local.queries[count.index]}.tmpl")
  vars = {
    account_id              = data.aws_caller_identity.current.account_id
    database_and_table_name = format("%s.%s", local.db_name, local.db_name)
    target_location         = format("%s/%s", var.target_bucket, var.target_prefix)
  }
}

# This query is created and needs to be run one time manually to create the table
resource "aws_athena_named_query" "query" {
  count = length(local.queries)

  name        = local.queries[count.index]
  description = format("%s for querying s3 access logs", local.queries[count.index])
  workgroup   = module.athena_workgroup.id
  database    = aws_athena_database.access_logs.name
  query       = data.template_file.query[count.index].rendered
}
