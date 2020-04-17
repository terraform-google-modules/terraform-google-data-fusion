resource "null_resource" "wait_healthy" {
  provisioner "local-exec" {
    command = "${path.module}/wait_healthy.sh -e ${var.service_endpoint} -t ${var.access_token}"
  }
}
