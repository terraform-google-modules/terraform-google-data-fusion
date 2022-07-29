# Data Fusion Private Network Setup

This module can be used to deploy the networking pre-reqs for a
[Private IP Data Fusion Instance](https://cloud.google.com/data-fusion/docs/how-to/create-private-ip).
Namely:
- VPC Network
- Custom subnet to deploy Dataproc clusters in
- IP allocation for the Peering with the data fusion tenant project VPC
- VPC Peering to tenant project
- SSH ingress rule to allow the Data Fusion Instance to reach Dataproc clusters on port 22.

## Usage

Basic usage of this module is as follows:

```hcl
module "private_data_fusion_network" {
  source  = "terraform-google-modules/data-fusion/google//modules/private_data_fusion_network"
  version = "~> 0.1"

  project_id  = "your-gcp-project-id"
  vpc_network = "data-fusion-net"
}
```

Functional examples are included in the
[examples](../../examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| data\_fusion\_service\_account | The Google managed Data Fusion Service account | `string` | n/a | yes |
| dataproc\_cidr | CIDR range for the subnetwork for Dataproc clusters controlled by private Data Fusion instance | `string` | `"10.2.0.0/16"` | no |
| dataproc\_subnet | Name of the subnetwork for Dataproc clusters controlled by private Data Fusion instance | `string` | `"dataproc-subnet"` | no |
| instance | Private Data Fusion instance ID | `string` | n/a | yes |
| network\_name | VPC network to be created or configured with firewall rules and peering for private Data Fusion instance | `string` | n/a | yes |
| project\_id | GCP Project ID to house resources for private Data Fusion setup | `string` | n/a | yes |
| region | GCP region to create subnetwork for peering with private Data Fusion instance | `string` | `"us-central1"` | no |
| tenant\_project | Private Data Fusion instance ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| data\_fusion\_ip\_allocation | The IP CIDR range reserved for the private Data Fusion instance |
| data\_fusion\_vpc | The VPC created for the private Data Fusion instance |
| dataproc\_subnet | The subnetwork created for Dataproc clusters controlled by the private Data Fusion instance |
| network\_name | The VPC created for the private Data Fusion instance |

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

- Compute Network Admin: `roles/compute.networkAdmin`

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
