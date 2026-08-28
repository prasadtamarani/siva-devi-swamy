terraform {
  required_version = ">= 1.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.28.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.28.0"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-log-export:storage/v7.4.1"
  }

}

provider "google" {
}

