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
  description = "Name of the profile"
  type        = string
}

variable "label" {
  description = "Label of the profile"
  type        = string
}

variable "project" {
  description = "ID of the project hosting the cluster"
  type        = string
  default     = "auto-detect"
}

variable "region" {
  description = "Region of the dataproc cluster"
  type        = string
  default     = "auto-detect"
}

variable "network" {
  description = "Network to use for the cluster"
  type        = string
  default     = "default"
}

variable "network_host_project_id" {
  description = "Project ID of the network"
  type        = string
  default     = ""
}

variable "subnet" {
  description = "Subnet to use for the cluster"
  type        = string
  default     = ""
}

variable "service_account" {
  description = "Service account to run the cluster as"
  type        = string
  default     = ""
}

variable "gcs_bucket" {
  description = "Bucket to write cluster job and data data"
  type        = string
  default     = ""
}

variable "account_key" {
  description = "Service account key to use for authentication"
  type        = string
  default     = ""
}

variable "image_version" {
  description = "Dataproc image version to use for the cluster"
  type        = string
  default     = ""
}

variable "encryption_key_name" {
  description = "Customer supplied encryption key used by the cluster"
  type        = string
  default     = ""
}

variable "master" {
  description = "Config of the cluster master"
  type = object({
    num_nodes = number
    num_cpus  = number
    memory_mb = number
    disk_gb   = number
  })
  default = {
    num_nodes = 1
    num_cpus  = 8
    memory_mb = 52000
    disk_gb   = 1000
  }
}

variable "worker" {
  description = "Config of the cluster worker"
  type = object({
    num_nodes = number
    num_cpus  = number
    memory_mb = number
    disk_gb   = number
  })
  default = {
    num_nodes = 5
    num_cpus  = 1
    memory_mb = 52000
    disk_gb   = 1000
  }
}
