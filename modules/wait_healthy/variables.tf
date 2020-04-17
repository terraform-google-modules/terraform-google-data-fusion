variable "service_endpoint" {
    description = "Endpoint of the the CDF instance to check for health."
    type = string
}

variable "access_token" {
    description = "Token for authenticating requests to the CDF instance."
    type = string
}
