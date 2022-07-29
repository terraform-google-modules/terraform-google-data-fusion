# terraform-google-data-fusion

This module handle opinionated Google Cloud Platform Data Fusion instances.

## Usage

Basic usage of this module is as follows:

```hcl
module "data_fusion" {
  source  = "terraform-google-modules/data-fusion/google"
  version = "~> 0.1"

  name    = "example-instance"
  project = "example-project"
  region  = "us-central1"
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| data\_fusion\_service\_account | Google Managed Data Fusion Service Account Email | `any` | n/a | yes |
| datafusion\_version | Data Fusion Version to deploy. | `string` | `null` | no |
| dataproc\_subnet | Name for subnet to create and configure for Dataproc clusters controlled by private Data Fusion instance. | `string` | `"dataproc-subnet"` | no |
| description | An optional description of the instance. | `string` | `null` | no |
| labels | The resource labels for instance to use to annotate any related underlying resources, such as Compute Engine VMs. | `map(string)` | `{}` | no |
| name | Name of the instance. | `string` | n/a | yes |
| network | Name for VPC to create or reuse to be configured for use with private Data Fusion instance. | `string` | n/a | yes |
| options | Map of additional options used to configure the behavior of Data Fusion instance. | `map(string)` | `{}` | no |
| project | The project ID to deploy to. | `string` | n/a | yes |
| region | The region of the instance. | `string` | n/a | yes |
| type | Represents the type of the instance (BASIC or ENTERPRISE) | `string` | `"ENTERPRISE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance | The created CDF instance |
| tenant\_project | The Google managed tenant project ID in which the instance will run its jobs |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13+
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v4.12

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
