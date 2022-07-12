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

variable "name" {
  description = "Name of the instance."
  type        = string
}

variable "project" {
  description = "The project ID to deploy to."
  type        = string
}

variable "datafusion_version" {
  description = "Data Fusion Version to deploy."
  type        = string
  default     = null
}

variable "description" {
  description = "An optional description of the instance."
  type        = string
  default     = null
}

variable "region" {
  description = "The region of the instance."
  type        = string
}

variable "type" {
  description = "Represents the type of the instance (BASIC or ENTERPRISE)"
  type        = string
  default     = "ENTERPRISE"
}

variable "labels" {
  description = "The resource labels for instance to use to annotate any related underlying resources, such as Compute Engine VMs."
  type        = map(string)
  default     = {}
}

variable "options" {
  description = "Map of additional options used to configure the behavior of Data Fusion instance."
  type        = map(string)
  default     = {}
}

variable "network_config" {
  description = "Network configuration options as defined in https://www.terraform.io/docs/providers/google/r/data_fusion_instance.html#network_config. Setting this implies a private instance."
  type = object({
    network       = string
    ip_allocation = string
  })
  default = null
}
