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


provider "google" {
  version = "~> 3.0"
}

data "google_client_config" "current" {}

resource "google_project_service" "project" {
  project = var.project_id
  service = "datafusion.googleapis.com"

  disable_dependent_services = true
}

resource "google_compute_network_peering" "peering1" {
  name         = "data-fusion-peering"
  network      = var.vpc_network_self_link
  peer_network = "projects/${var.tenant_project}/global/networks/${var.region}-${var.instance}"
  import_custom_routes = "true"
  export_custom_routes = "true"
}

resource "google_compute_subnetwork" "dataproc" {
  project                  = var.project_id
  name                     = var.dataproc_subnet
  ip_cidr_range            = var.dataproc_cidr
  region                   = var.region
  network                  = var.vpc_network_self_link
  private_ip_google_access = true
}

resource "google_compute_global_address" "data_fusion_private_ip_alloc" {
  project       = var.project_id
  name          = "data-fusion-private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 22
  network       = var.vpc_network_self_link
}

resource "google_compute_firewall" "allow-data-fusion-ssh" {
  project = var.project_id
  name    = "allow-private-data-fusion-ssh"
  network = var.vpc_network_self_link

  priority = "80"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges      = ["${google_compute_global_address.data_fusion_private_ip_alloc.address}/${google_compute_global_address.data_fusion_private_ip_alloc.prefix_length}"]
  direction          = "INGRESS"
}

resource "google_compute_firewall" "dataproc_internal" {
  name    = "allow-dataproc-internal"
  project = var.project_id
  network = var.vpc_network_self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }

  source_ranges      = [google_compute_subnetwork.dataproc.ip_cidr_range]
}
