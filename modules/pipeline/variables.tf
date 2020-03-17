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
  description = "The name of the artifact."
  type        = string
}

variable "json_spec_path" {
  description = "The exported JSON pipeline spec with the checkpointDir key removed."
  type        = string
}

variable "namespace" {
  description = "The name of the namespace which resource belongs."
  type        = string
}

variable "macros" {
  description = "macros that should be rendered at terraform apply time due to CDAP-10941"
  type        = map
  default     = {}
}

variable "artifacts" {
  description = "A list of artifacts (such as custom plugins) that this pipeline uses. This creates the dependency in terraform."
  type        = list
  default     = []
}
