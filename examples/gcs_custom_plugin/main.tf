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

provider "google" {
  version = "~> 3.0"
}

data "google_client_config" "current" {
}

provider "cdap" {
  host  = "https://example-df-host.com/api/"
  token = data.google_client_config.current.access_token
}

module "verbose_plugin" {
  source = "../../modules/custom_plugin"

jar_binary_path                     = var.jar_binary_path
json_config_path                = var.json_config_path
version_x                           = var.version_x
name                         = "sample_name"
namespace                    = "default"
data_fusion_service_endpoint = var.data_fusion_service_endpoint
	
}

  
  
