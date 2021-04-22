locals {
  local_network_name = element(reverse(split("/", var.local_network)), 0)
  peer_network_name  = element(reverse(split("/", var.peer_network)), 0)

  local_network_peering      = "${var.prefix}-${local.local_network_name}-${local.peer_network_name}"
  local_network_peering_name = length(local.local_network_peering) < 63 ? local.local_network_peering : "${substr(local.local_network_peering, 0, min(58, length(local.local_network_peering)))}-${random_string.network_peering_suffix.result}"
  peer_network_peering       = "${var.prefix}-${local.peer_network_name}-${local.local_network_name}"
  peer_network_peering_name  = length(local.peer_network_peering) < 63 ? local.peer_network_peering : "${substr(local.peer_network_peering, 0, min(58, length(local.peer_network_peering)))}-${random_string.network_peering_suffix.result}"
}

resource "random_string" "network_peering_suffix" {
  upper   = false
  lower   = true
  special = false
  length  = 4
}

resource "google_compute_network_peering" "local_network_peering" {
  provider             = google-beta
  name                 = local.local_network_peering_name
  network              = var.local_network
  peer_network         = var.peer_network
  export_custom_routes = var.export_local_custom_routes
  import_custom_routes = var.export_peer_custom_routes

  export_subnet_routes_with_public_ip = var.export_local_subnet_routes_with_public_ip
  import_subnet_routes_with_public_ip = var.export_peer_subnet_routes_with_public_ip

  depends_on = [null_resource.module_depends_on]
}

resource "null_resource" "module_depends_on" {
  triggers = {
    value = length(var.module_depends_on)
  }
}

resource "null_resource" "complete" {
  depends_on = [google_compute_network_peering.local_network_peering]
}
