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

provider "google" {
  version = "~> 3.0"
}

data "google_client_config" "current" {
}


module "data_fusion_network" {
  source          = "./modules/private_data_fusion_network"
  project_id      = var.project
  tenant_project  = module.instance.tenant_project
  instance        = module.instance.instance.name
  vpc_network     = var.network
  dataproc_subnet = var.dataproc_subnet
  region          = var.region
}

module "instance" {
  source = "./modules/instance"

  name        = var.name
  project     = var.project
  description = var.description
  region      = var.region
  type        = var.type
  labels      = var.labels
  options     = var.options
  network_config = {
    network       = module.data_fusion_network.data_fusion_vpc.name
    ip_allocation = module.data_fusion_network.data_fusion_ip_allocation
  }
}

provider "cdap" {
  host  = "${module.instance.instance.service_endpoint}/api/"
  token = data.google_client_config.current.access_token
}

module "verbose_dataproc" {
  source = "./modules/dataproc_profile"

  name    = var.custom_profile_name
  label   = var.custom_profile_name
  region  = var.region
  network = module.data_fusion_network.data_fusion_vpc.name
  subnet  = module.data_fusion_network.dataproc_subnet.name
  extra_properties = {
    "dataproc:dataproc.logging.stackdriver.job.yarn.container.enable" = true
  }
}
