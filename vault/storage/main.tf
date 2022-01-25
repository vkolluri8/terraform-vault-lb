resource "google_storage_bucket" "vault" {
  project       = var.project_id
  name          = "${var.vault_storage_bucket}"
  location      = "US"
  force_destroy = false
}