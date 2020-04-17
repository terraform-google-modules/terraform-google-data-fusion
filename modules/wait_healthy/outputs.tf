output "service_endpoint" {
    description = "The input service_endpoint. Useful for creating a dependency on this module."
    value = var.service_endpoint
    depends_on = [
        null_resource.wait_healthy,
    ]
}
