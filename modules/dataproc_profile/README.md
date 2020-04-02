# Dataproc Profile

This module can be used to deploy a custom compute profile for a GCP dataproc
provisioner. The default dataproc provisioner has unconfigurable settings such
as using the default network and default compute service account which are often
not desired.

## Usage

Basic usage of this module is as follows:

```hcl
data "google_client_config" "current" {}

provider "cdap" {
  host  = "https://example-instance-example-project-dot-usc1.datafusion.googleusercontent.com/api/"
  token = data.google_client_config.current.access_token
}

module "custom_dataproc" {
  source  = "terraform-google-modules/data-fusion/google//modules/dataproc_profile"
  version = "~> 0.1"

  name   = "custom-dataproc"
  label  = "Custom Dataproc Profile"

  network         = "example-network"
  subnet          = "example-subnetwork"
  service_account = "example-sa"
  gcs_bucket      = "example-bucket"
}
```

Functional examples are included in the
[examples](../../examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_key | Service account key to use for authentication | string | `""` | no |
| encryption\_key\_name | Customer supplied encryption key used by the cluster | string | `""` | no |
| gcs\_bucket | Bucket to write cluster job and data data | string | `""` | no |
| image\_version | Dataproc image version to use for the cluster | string | `""` | no |
| label | Label of the profile | string | n/a | yes |
| master | Config of the cluster master | object | `<map>` | no |
| name | Name of the profile | string | n/a | yes |
| namespace | Namespace to deploy profile in | string | `"default"` | no |
| network | Network to use for the Dataproc cluster | string | `"default"` | no |
| network\_host\_project\_id | Project ID of the network | string | `""` | no |
| project | ID of the project hosting the cluster | string | `"auto-detect"` | no |
| region | Region of the dataproc cluster | string | `"auto-detect"` | no |
| service\_account | Service account to run the cluster as | string | `""` | no |
| subnet | Subnet to use for the cluster | string | `""` | no |
| worker | Config of the cluster worker | object | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| profile | The created profile |

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
