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

module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 6.0"
  project_id   = var.project_id
  network_name = var.network_name
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

resource "google_compute_network_peering" "data-fusion-peering" {
  name                 = "data-fusion-peering"
  network              = module.vpc.network_self_link
  peer_network         = "projects/${var.tenant_project}/global/networks/${var.region}-${var.instance}"
  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_global_address" "data_fusion_private_ip_alloc" {
  project       = var.project_id
  name          = "data-fusion-private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 22
  network       = module.vpc.network_self_link
}

module "datafusion_firewall" {
  source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  project_id              = var.project_id
  network                 = module.vpc.network_name
  internal_ranges_enabled = true
  internal_ranges         = module.vpc.subnets_ips

  custom_rules = {
    dataproc-internal = {
      description = "Allow hosts in dataproc subnet to talk to each other on all ports"
      direction   = "INGRESS"
      action      = "allow"
      ranges      = [module.vpc.subnets["${var.region}/${var.dataproc_subnet}"].ip_cidr_range]

      use_service_accounts = false
      rules = [{
        protocol = "tcp"
        ports    = ["22"]
        },
        {
          protocol = "icmp"
          ports    = []
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

      sources = null
      targets = null

      extra_attributes = {
        priority = 80
      }
    }
    allow-data-fusion-ssh = {
      description          = "Allow IPs from the the allocation for private data fusion instance to SSH to dataproc clusters"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = ["${google_compute_global_address.data_fusion_private_ip_alloc.address}/${google_compute_global_address.data_fusion_private_ip_alloc.prefix_length}"]
      use_service_accounts = true

      rules = [{
        protocol = "tcp"
        ports    = ["22"]
      }]

      sources = [var.data_fusion_service_account]
      targets = null

      extra_attributes = {
        priority = 80
      }
    }
  }
}
