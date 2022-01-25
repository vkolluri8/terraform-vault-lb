terraform {
  backend "gcs" {
    bucket  = "vault-non-prod-gcs"
    prefix = "kms"
  }
}