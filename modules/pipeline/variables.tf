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

variable "artifact" {
  description = "The artifact used to create the pipeline."
  type        = string
}

variable "artifact_name" {
  description = "The name of the artifact."
  type        = string
}

variable "json_config_path" {
  description = "relative path to exported pipeline JSON"
  type        = string
}

variable "name" {
  description = "Name of the instance."
  type        = string
}

variable "namespace" {
  description = "The name of the namespace which resource belongs."
  type        = string
}

variable "data_fusion_service_endpoint" {
  description = "Endpoint hit when CDF is called"
  type        = string
}


