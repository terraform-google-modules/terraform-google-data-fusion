# Pipeline Configuration

This example illustrates how to use the `pipeline_config` module.
This will automate deploying a data fusion app but will not start it.
Starting a program run should be managed as a separate `streaming_program_run` resource.
Batch pipelines should not be managed with terraform as they would be restarted on every terraform apply [See similar context for `google_dataflow_job` resource](https://www.terraform.io/docs/providers/google/r/dataflow_job.html#note-on-quot-destroy-quot-quot-apply-quot-). 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| artifact | The artifact used to create the pipeline | string | `"N/A"` | yes |
| artifact\_name | The name of the artifact. | string | `"N/A"` | yes |
| data\_fusion\_service\_endpoint | URL of instance (endpoint) | string | `"N/A"` | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
