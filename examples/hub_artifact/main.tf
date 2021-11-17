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

data "google_client_config" "current" {
}

provider "cdap" {
  host  = "https://example-df-host.com/api/"
  token = data.google_client_config.current.access_token
}

module "connectors_streaming_1_0_0" {
  source = "../../modules/hub_artifact"

  bucket           = "aeba5c94-db31-451a-85ea-27047cbe133b" # Healthcare hub.
  package          = "healthcare-cloud-api-connectors"
  name             = "connectors-streaming"
  artifact_version = "1.0.0"
}
