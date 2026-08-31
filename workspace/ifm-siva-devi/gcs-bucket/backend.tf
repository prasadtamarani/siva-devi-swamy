terraform {
  backend "gcs" {
    bucket = "test-siva-devi"
    prefix = "statefile/gcs-18"
  }
}
