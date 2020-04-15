/**
 * Copyright 2018 Google LLC
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

output "network_name" {
  description = "The VPC created for the private Data Fusion instance"
  value       = module.vpc.network_name
}

output "data_fusion_vpc" {
  description = "The VPC created for the private Data Fusion instance"
  value       = module.vpc.network
}

output "dataproc_subnet" {
  description = "The subnetwork created for Dataproc clusters controlled by the private Data Fusion instance"
  value       = module.vpc.subnets["${var.region}/${var.dataproc_subnet}"]
}

output "data_fusion_ip_allocation" {
  description = "The IP CIDR range reserved for the private Data Fusion instance"
  value       = "${google_compute_global_address.data_fusion_private_ip_alloc.address}/${google_compute_global_address.data_fusion_private_ip_alloc.prefix_length}"
}

