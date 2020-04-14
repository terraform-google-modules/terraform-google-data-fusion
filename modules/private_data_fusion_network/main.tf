/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


data "google_client_config" "current" {}

resource "google_project_service" "project" {
  project = var.project_id
  service = "datafusion.googleapis.com"

  disable_dependent_services = true
}

module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 2.2"
  project_id   = var.project_id
  network_name = var.vpc_network
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = var.dataproc_subnet
      subnet_ip             = var.dataproc_cidr
      subnet_region         = var.region
      subnet_private_access = true
    }
  ]
}

module "peering" {
  source                     = "terraform-google-modules/terraform-google-network/google//modules/network-peering"
  prefix                     = "data-fusion-peering"
  local_network              = module.vpc.self_link
  peer_network               = "projects/${var.tenant_project}/global/networks/${var.region}-${var.instance}"
  export_local_custom_routes = true
  export_peer_custom_routes  = true
}

resource "google_compute_global_address" "data_fusion_private_ip_alloc" {
  project       = var.project_id
  name          = "data-fusion-private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 22
  network       = var.vpc_network_self_link
}

module "datafusion_firewall" {
  source                  = "terraform-google-modules/terraform-google-network/google//modules/fabric-net-firewall"
  project_id              = var.project_id
  network                 = module.vpc.network_name
  internal_ranges_enabled = true
  internal_ranges         = module.vpc.subnets_ips

  custom_rules = local.custom_rules
}

locals {
  custom_rules = {
    allow-data-fusion-ssh = {
      description = "Allow IPs from the the allocation for private data fusion instance to SSH to dataproc clusters"
      direction   = "INGRESS"
      action      = "allow"
      ranges      = ["${google_compute_global_address.data_fusion_private_ip_alloc.address}/${google_compute_global_address.data_fusion_private_ip_alloc.prefix_length}"]

      rules = [{
        protocol = "tcp"
        ports    = ["22"]
      }]

      extra_attributes = {
        priority = 80
      }
    }

    dataproc-internal = {
      description = "Allow IPs in dataproc subnet to talk to each other on all ports"
      action      = "allow"
      ranges      = [google_compute_subnetwork.dataproc.ip_cidr_range]

      rules = [
        {
          protocol = "tcp"
          ports    = ["22"]
        },
        {
          protocol = "icmp"
        },
        {
          protocol = "tcp"
          ports    = ["1-65535"]
        },

        {
          protocol = "udp"
          ports    = ["1-65535"]
        }
      ]

      extra_attributes = {
        priority = 80
      }
    }
  }
}
