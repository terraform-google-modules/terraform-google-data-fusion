# Pipeline Module

This module can be used to deploy a CDF pipeline in GCP. 

## Usage

Basic usage of this module is as follows:

```hcl
data "google_client_config" "current" {}

provider "cdap" {
  host  = "https://example-instance-example-project-dot-usc1.datafusion.googleusercontent.com/api/"
  token = data.google_client_config.current.access_token
}

module "custom_instance" {
  source  = "terraform-google-modules/data-fusion/google//modules/dataproc_provisioner"
  version = "~> 0.1"

  name   = "instance"


  network         = "example-network"
  subnet          = "example-subnetwork"
  service_account = "example-sa"
 
}
```

Functional examples are included in the
[examples](../../examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name of the instance. | string | `""` | no |
| project | The project ID to deploy to. | string | `""` | no |
| description | An optional description of the instance. | string | `""` | no |
| region | The region of the instance. | string | `""` | no |
| type | Represents the type of the instance (basic or enterprise) | string | `""` | no |
| labels | The resource labels for instance to use to annotate any related underlying resources, such as Compute Engine VMs. | map(string) | n/a | yes |
| options | Map of additional options used to configure the behavior of Data Fusion instance. | map(string) | n/a | no |
| network\_config | Network configuration options as defined in https://www.terraform.io/docs/providers/google/r/data_fusion_instance.html#network_config. Setting this implies a private instance. | object | n/a | yes |
| 

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
