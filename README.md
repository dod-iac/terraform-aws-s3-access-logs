<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Creates athena and s3 resources to query s3 access logs

* S3 bucket for athena query results
* Athena workgroup, database, and named query to create table
* Example queries for use against access logs

```hcl
module "s3_access_locs" {
  source = "dod-iac/s3-access-logs/aws"

  target_bucket  = "log-bucket-name"
  logging_bucket = "log-bucket-name"

  tags = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}
```

## Setup

After applying the resources there is one manual step. Run the `create_table` named query to create the table to query against.

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |
| <a name="provider_template"></a> [template](#provider\_template) | ~> 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_athena_workgroup"></a> [athena\_workgroup](#module\_athena\_workgroup) | dod-iac/athena-workgroup/aws |  |
| <a name="module_aws_s3_bucket_kms_key"></a> [aws\_s3\_bucket\_kms\_key](#module\_aws\_s3\_bucket\_kms\_key) | dod-iac/s3-kms-key/aws | ~> 1.0.1 |
| <a name="module_query_results"></a> [query\_results](#module\_query\_results) | trussworks/s3-private-bucket/aws | 3.4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_athena_database.access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_database) | resource |
| [aws_athena_named_query.query](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_named_query) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [template_file.query](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | The S3 bucket to send logs for query results bucket | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Unique name for the set of logs being analyzed | `string` | `"s3-access-logs"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources | `map(string)` | <pre>{<br>  "Automation": "Terraform"<br>}</pre> | no |
| <a name="input_target_bucket"></a> [target\_bucket](#input\_target\_bucket) | The S3 bucket to target for s3 access logs. | `string` | n/a | yes |
| <a name="input_target_prefix"></a> [target\_prefix](#input\_target\_prefix) | The S3 prefix to target for s3 access logs | `string` | `"s3"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
