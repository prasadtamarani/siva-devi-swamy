variable "list_of_buckets" {
  description = "List of GCS buckets to create"
  type = list(object({
    project_id          = string
    storage_bucket_name = string
    location            = string
    storage_class       = optional(string, "STANDARD")
    force_destroy       = optional(bool, false)
    retention_policy = optional(object({
      is_locked             = bool
      retention_period_days = number
    }), null)
    lifecycle_rules = optional(set(object({
      action    = map(string)
      condition = map(string)
    })), [])
  }))
}

