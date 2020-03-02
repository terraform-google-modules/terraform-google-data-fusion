# Pipeline Configuration

This example illustrates how to use the `pipeline_config` module.

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
