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

output "instance" {
  value       = google_data_fusion_instance.instance
  description = "The created CDF instance"
}

locals {
  tenant_project_re = "cloud-datafusion-management-sa@([\\w-]+).iam.gserviceaccount.com"
}

output "tenant_project" {
  value       = regex(local.tenant_project_re, google_data_fusion_instance.instance.service_account)[0]
  description = "The Google managed tenant project ID in which the instance will run its jobs"
}

output "service_account" {
  value       = google_data_fusion_instance.instance.service_account
  description = "The Google managed Data Fusion Service account"
}
