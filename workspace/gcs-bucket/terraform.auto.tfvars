
project = {
  name            = "siva-devi"
  service_account = "sa-terraform-lz@siva-devi.iam.gserviceaccount.com"
}
  
list_of_buckets = [
  {
    project_id          = "siva-devi"
    storage_bucket_name = "bkt-siva-devi-logs"
    location            = "asia-south1"
    storage_class       = "STANDARD"
    force_destroy       = false
    lifecycle_rules     = []
    retention_policy    = null

    # retention_policy = {
    #   is_locked             = false
    #   retention_period_days = 0    # minimum 1 day to satisfy org policy
    # }
    # Uncomment when ready to enable archival transition
    # lifecycle_rules = [
    #   {
    #     action    = { type = "Delete", storage_class = null }
    #     condition = { age = "365" }
    #   }
    # ]
  }
]


