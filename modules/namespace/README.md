# CDAP Namespace with Preferences

This module can be used to manage CDAP namespaces with terraform.
It supports defining a namespace and all it's preferences in a single module call
## Usage

Basic usage of this module is as follows:

```hcl
data "google_client_config" "current" {}

provider "cdap" {
  host  = "https://example-df-host.com/api/"
  token = data.google_client_config.current.access_token
}

module "staging" {
  source  = "terraform-google-modules/data-fusion/google//modules/namespace"
  version = "~> 0.1"

  name = var.name
  preferences = {
    FOO = "BAR"
  }
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the namespace | `string` | n/a | yes |
| preferences | Name of the preferences to set in this namespace | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name | The created CDAP namespace |
| preferences | The preferences set in the CDAP namespace |

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
