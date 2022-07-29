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


module "data_fusion_network" {
  source                      = "./modules/private_network"
  project_id                  = var.project
  tenant_project              = module.instance.tenant_project
  data_fusion_service_account = module.instance.service_account
  instance                    = module.instance.instance.name
  network_name                = var.network
  dataproc_subnet             = var.dataproc_subnet
  region                      = var.region
}

module "instance" {
  source = "./modules/instance"

  name               = var.name
  project            = var.project
  description        = var.description
  region             = var.region
  type               = var.type
  labels             = var.labels
  datafusion_version = var.datafusion_version
  options            = var.options
  network_config = {
    network       = module.data_fusion_network.data_fusion_vpc.network_name
    ip_allocation = module.data_fusion_network.data_fusion_ip_allocation
  }
}

