terraform {
  backend "gcs" {
    bucket = "gcp-terraform-state-04152024"
    prefix = "values/terraform.tfstate"
  }
}