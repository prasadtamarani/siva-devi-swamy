module "log_bucket" {
  providers = {
    google      = google.project
    google-beta = google-beta.project-beta
  }
  for_each                    = { for bucket in var.list_of_buckets : bucket.storage_bucket_name => bucket }
  source                      = "../../modules/gcs-bucket"
  project_id                  = each.value.project_id
  storage_bucket_name         = each.value.storage_bucket_name
  location                    = each.value.location
  storage_class               = each.value.storage_class
  force_destroy               = each.value.force_destroy
  uniform_bucket_level_access = true
  lifecycle_rules             = each.value.lifecycle_rules
  retention_policy            = each.value.retention_policy
}

