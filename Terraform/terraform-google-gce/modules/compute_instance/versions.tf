terraform {
  required_version = ">= 0.13.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.45, < 4.0"
    }
  }
  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-folders/v3.0.0"
  }
}
