terraform {
  required_version = ">= 1.7.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.33.0, < 8.0.0" # tftest
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 7.33.0, < 8.0.0" # tftest
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-log-export:storage/v7.4.1"
  }

}
