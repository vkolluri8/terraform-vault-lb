# Add the service account to the Keyring
resource "google_kms_key_ring_iam_binding" "vault_iam_kms_binding" {
   key_ring_id = "projects/${var.project_id}/locations/${var.region}/keyRings/${var.kms_keyring}"
   role = "roles/owner"

   members = [
     "serviceAccount:${var.vault_service_account_email}",
   ]
}