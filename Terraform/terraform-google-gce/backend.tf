terraform {
  backend "gcs" {
    bucket = "learn-gcpdevops-terraform-state-file"
    prefix = "terraform/state"
  }
}