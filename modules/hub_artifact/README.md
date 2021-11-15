# Hub Artifact

This module can be used to deploy an artifact (plugin) from the GCS bucket of
a data fusion instance hub.

## Usage

Basic usage of this module is as follows:

```hcl
data "google_client_config" "current" {}

provider "cdap" {
  host  = "https://example-instance-example-project-dot-usc1.datafusion.googleusercontent.com/api/"
  token = data.google_client_config.current.access_token
}

module "connectors_streaming_1_0_0" {
  source = "../../modules/data_fusion/modules/hub_artifact"

  bucket           = "aeba5c94-db31-451a-85ea-27047cbe133b" # Healthcare hub.
  package          = "healthcare-cloud-api-connectors"
  name             = "connectors-streaming"
  artifact_version = "1.0.0"
  namespace        = cdap_namespace.namespace.name
}
```

Functional examples are included in the
[examples](../../examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| artifact\_version | Version of the artifact. | `string` | n/a | yes |
| bucket | Name of the GCS bucket for the hub. | `string` | n/a | yes |
| name | Name of the artifact within the package. | `string` | n/a | yes |
| namespace | Namespace to create the artifact in. | `string` | `null` | no |
| package | Name of the package within the hub bucket that contains the artifact. | `string` | n/a | yes |
| package\_version | Version of the package. If not set, the artifact version is used. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| artifact | The created artifact. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

This module requires the
[Terraform CDAP provider](https://googlecloudplatform.github.io/terraform-provider-cdap/).

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v2.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Data Fusion Admin: `roles/datafusion.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Data Fusion API: `datafusion.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
