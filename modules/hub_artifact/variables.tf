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

variable "bucket" {
  description = "Name of the GCS bucket for the hub."
  type        = string
}

variable "package" {
  description = "Name of the package within the hub bucket that contains the artifact."
  type        = string
}

variable "name" {
  description = "Name of the artifact within the package."
  type        = string
}

variable "artifact_version" {
  description = "Version of the artifact."
  type        = string
}

variable "package_version" {
  description = "Version of the package. If not set, the artifact version is used."
  type        = string
  default     = null
}

variable "namespace" {
  description = "Namespace to create the artifact in."
  type        = string
  default     = null
}
