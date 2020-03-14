# GCS Custom Plugin Module

This example illustrates how to use the `gcs_custom_plugin` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| artifact\_name | The name of the artifact. This will be the app name | string | `"custom_plugin"` | yes |
| data\_fusion\_service\_endpoint | The URL of the instance. (apiEndpoint). | string | `"n/a"` | yes |
| jar\_binary\_path | Path to binary for plugin. | string | `"n/a"` | yes |
| json\_config\_path | Path of the JSON file. | string | `"n/a"` | yes |
| version | Artifact version. | string | `"n/a"` | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
