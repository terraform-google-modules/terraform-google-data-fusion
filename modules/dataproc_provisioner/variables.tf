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
  description = "CDAP Label of the profile"
  type        = string
}

variable "namespace" {
  description = "Namespace to deploy profile in"
  type        = string
  default     = "default"
}

variable "project" {
  description = "ID of the project hosting the Dataproc cluster"
  type        = string
  default     = "auto-detect"
}

variable "region" {
  description = "Region of the Dataproc cluster"
  type        = string
  default     = "auto-detect"
}

variable "network" {
  description = "Network to use for the Dataproc cluster"
  type        = string
  default     = "default"
}

variable "network_host_project_id" {
  description = "Project ID of the network"
  type        = string
  default     = ""
}

variable "subnet" {
  description = "Subnet to use for the Dataproc cluster"
  type        = string
  default     = ""
}

variable "service_account" {
  description = "Service account to run the Dataproc cluster as"
  type        = string
  default     = ""
}

variable "gcs_bucket" {
  description = "Dataproc Staging Bucket for job staging job artifacts and driver logs."
  type        = string
  default     = ""
}

variable "account_key" {
  description = "Service account key to use for authentication"
  type        = string
  default     = ""
}

variable "image_version" {
  description = "Dataproc image version to use for the Dataproc cluster"
  type        = string
  default     = ""
}

variable "encryption_key_name" {
  description = "Customer supplied encryption key used by the Dataproc cluster"
  type        = string
  default     = ""
}

variable "extra_properties" {
  description = "Extra properties for the CDAP Profile payload. This can include Dataproc Cluster Properties https://cloud.google.com/dataproc/docs/concepts/configuring-clusters/cluster-properties"
  type        = map(string)
  default     = {}
}


variable "master" {
  description = "Config of the Dataproc cluster master"
  type = object({
    num_nodes = number
    num_cpus  = number
    memory_gb = number
    disk_gb   = number
  })
  default = {
    num_nodes = 1
    num_cpus  = 8
    memory_gb = 52
    disk_gb   = 1000
  }
}

variable "worker" {
  description = "Config of the Dataproc cluster worker"
  type = object({
    num_nodes = number
    num_cpus  = number
    memory_gb = number
    disk_gb   = number
  })
  default = {
    num_nodes = 5
    num_cpus  = 8
    memory_gb = 52
    disk_gb   = 1000
  }
}
