resource "google_storage_bucket" "bucket" {
  name                        = var.storage_bucket_name
  project                     = var.project_id
  storage_class               = var.storage_class
  location                    = var.location
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access
  public_access_prevention    = "enforced"
  labels                      = var.storage_bucket_labels

  versioning {
    enabled = var.versioning
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules

    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }

      condition {
        age                    = lookup(lifecycle_rule.value.condition, "age", null)
        created_before         = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state             = lookup(lifecycle_rule.value.condition, "with_state", lookup(lifecycle_rule.value.condition, "is_live", false) ? "LIVE" : null)
        matches_storage_class  = contains(keys(lifecycle_rule.value.condition), "matches_storage_class") ? split(",", lifecycle_rule.value.condition["matches_storage_class"]) : null
        num_newer_versions     = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
        days_since_custom_time = lookup(lifecycle_rule.value.condition, "days_since_custom_time", null)
      }
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [var.retention_policy]

    content {
      is_locked        = var.retention_policy.is_locked
      retention_period = var.retention_policy.retention_period_days * 24 * 60 * 60
    }
  }

  dynamic "encryption" {
    for_each = var.kms_key_name == null ? [] : [var.kms_key_name]

    content {
      default_kms_key_name = var.kms_key_name
    }
  }

  dynamic "logging" {
    for_each = var.log_bucket == null ? [] : [var.log_bucket]

    content {
      log_bucket        = logging.value
      log_object_prefix = var.log_object_prefix
    }
  }

  lifecycle {
    ignore_changes = [
      lifecycle_rule[0].condition
    ]
  }
}