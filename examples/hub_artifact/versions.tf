terraform {
  required_providers {
    cdap = {
      source  = "GoogleCloudPlatform/cdap"
      version = "~> 0.9.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  required_version = ">= 0.13"
}
