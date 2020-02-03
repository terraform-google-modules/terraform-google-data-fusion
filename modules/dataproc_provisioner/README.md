# Dataproc Provisioner

This module can be used to deploy a custom compute profile for a GCP dataproc
provisioner. The default dataproc provisioner uses things like the default
network and default compute service account which is often not desirable.

This module requires the
[Terraform CDAP provider](https://googlecloudplatform.github.io/terraform-provider-cdap/).

## Usage

Basic usage of this module is as follows:

```hcl
data "google_client_config" "current" {}

provider "cdap" {
  host  = "https://example-instance-example-project-dot-usc1.datafusion.googleusercontent.com/api/"
  token = data.google_client_config.current.access_token
}

module "custom_dataproc" {
  source  = "terraform-google-modules/data-fusion/google//modules/dataproc_provisioner"
  version = "~> 0.1"

  name = "custom-dataproc"
  label = "Custom Dataproc"

}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_key | Service account key of the dataproc service account | string | `""` | no |
| gcs\_bucket | Bucket to write cluster job and data data | string | `""` | no |
| image\_version | Dataproc image version to use for the cluster | string | `""` | no |
| label | Label of the profile | string | n/a | yes |
| name | Name of the profile | string | n/a | yes |
| network | Network to use for the cluster | string | `"default"` | no |
| network\_host\_project\_id | Project ID of the network | string | `""` | no |
| project | ID of the project hosting the cluster | string | `"auto-detect"` | no |
| project | ID of the project hosting the cluster | string | `"auto-detect"` | no |
| region | Region of the dataproc cluster | string | `"auto-detect"` | no |
| service\_account | Service account to run the cluster as | string | `""` | no |
| subnet | Subnet to use for the cluster | string | `""` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v2.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Storage Admin: `roles/storage.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html