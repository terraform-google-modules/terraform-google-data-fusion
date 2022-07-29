# Data Fusion Wait Healthy

This module provides a way to wait for a Data Fusion Instance to become healthy.

Data Fusion Instances currently load their services in an asynchronous
manner. Thus, if one tries to create a pipeline or resource immediately after
the Data Fusion Instance has been created, they will get an error.

Rather than waiting for an arbitrary amount of time, this module will ping the
Data Fusion Instance until it has loaded the google-cloud plugin, which usually
indicates a healthy instance.

NOTE: In the future this module may be removed if Data Fusion allows users to
wait for specific services during instance creation.

## Usage

Basic usage of this module is as follows:

```hcl
data "google_client_config" "current" {}

resource "google_data_fusion_instance" "instance" {
  provider = google-beta
  name     = "example-instance"
  project  = "example-project"
  region   = "us-central1"
  type     = "BASIC"
}

module "wait_healthy" {
  source  = "terraform-google-modules/data-fusion/google//modules/wait_healthy"
  version = "~> 0.1"

  service_endpoint = google_data_fusion_instance.instance.service_endpoint
  access_token     = data.google_client_config.current.access_token
}

provider "cdap" {
  host  = "${module.wait_healthy.service_endpoint}/api/"
  token = data.google_client_config.current.access_token
}

resource "cdap_application" "app" {
   ...
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_token | Token for authenticating requests to the CDF instance. | `string` | n/a | yes |
| service\_endpoint | Endpoint of the the CDF instance to check for health. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| service\_endpoint | The input service\_endpoint. Useful for creating a dependency on this module. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13+
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.53+

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
