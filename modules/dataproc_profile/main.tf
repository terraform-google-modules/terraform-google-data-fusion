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

resource "cdap_profile" "profile" {
  name      = var.name
  label     = var.label
  namespace = var.namespace

  profile_provisioner {
    name = "gcp-dataproc"
    properties {
      name        = "projectId"
      value       = var.project
      is_editable = true
    }
    properties {
      name        = "region"
      value       = var.region
      is_editable = true
    }
    properties {
      name        = "zone"
      value       = ""
      is_editable = true
    }
    properties {
      name        = "network"
      value       = var.network
      is_editable = true
    }
    properties {
      name        = "networkHostProjectId"
      value       = var.network_host_project_id
      is_editable = true
    }
    properties {
      name        = "subnet"
      value       = var.subnet
      is_editable = true
    }
    properties {
      name        = "imageVersion"
      value       = var.image_version
      is_editable = true
    }
    properties {
      name        = "serviceAccount"
      value       = var.service_account
      is_editable = true
    }
    properties {
      name        = "gcsBucket"
      value       = var.gcs_bucket
      is_editable = true
    }
    properties {
      name        = "encryptionKeyName"
      value       = var.encryption_key_name
      is_editable = true
    }
    properties {
      name        = "accountKey"
      value       = var.account_key
      is_editable = true
    }
    properties {
      name        = "masterNumNodes"
      value       = tostring(var.master.num_nodes)
      is_editable = true
    }
    properties {
      name        = "masterCPUs"
      value       = tostring(var.master.num_cpus)
      is_editable = true
    }
    properties {
      name        = "masterMemoryMB"
      value       = tostring(var.master.memory_gb * 1024)
      is_editable = true
    }
    properties {
      name        = "masterDiskGB"
      value       = tostring(var.master.disk_gb)
      is_editable = true
    }
    properties {
      name        = "workerNumNodes"
      value       = tostring(var.worker.num_nodes)
      is_editable = true
    }
    properties {
      name        = "workerCPUs"
      value       = tostring(var.worker.num_cpus)
      is_editable = true
    }
    properties {
      name        = "workerMemoryMB"
      value       = tostring(var.worker.memory_gb * 1024)
      is_editable = true
    }
    properties {
      name        = "workerDiskGB"
      value       = tostring(var.worker.disk_gb)
      is_editable = true
    }
    properties {
      name        = "preferExternalIp"
      value       = "false"
      is_editable = true
    }
    properties {
      name        = "stackdriverLoggingEnabled"
      value       = "true"
      is_editable = true
    }
    properties {
      name        = "stackdriverMonitoringEnabled"
      value       = "true"
      is_editable = true
    }
    properties {
      name        = "pollCreateDelay"
      value       = "60"
      is_editable = true
    }
    properties {
      name        = "pollCreateJitter"
      value       = "20"
      is_editable = true
    }
    properties {
      name        = "pollDeleteDelay"
      value       = "30"
      is_editable = true
    }
    properties {
      name        = "pollInterval"
      value       = "2"
      is_editable = true
    }

    dynamic "properties" {
      for_each = var.extra_properties

      content {
        name        = properties.key
        value       = properties.value
        is_editable = true
      }
    }
  }
}
