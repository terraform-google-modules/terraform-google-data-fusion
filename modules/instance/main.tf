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

resource "google_data_fusion_instance" "instance" {
  provider                      = google-beta
  name                          = var.name
  project                       = var.project
  description                   = var.description
  region                        = var.region
  type                          = var.type
  enable_stackdriver_logging    = true
  enable_stackdriver_monitoring = true
  labels                        = var.labels
  version                       = var.datafusion_version
  options                       = var.options
  private_instance              = var.network_config != null

  dynamic "network_config" {
    for_each = var.network_config == null ? [] : [var.network_config]
    content {
      network       = var.network_config.network
      ip_allocation = var.network_config.ip_allocation
    }
  }
}
