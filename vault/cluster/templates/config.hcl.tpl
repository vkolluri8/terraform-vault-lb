# Enable HA backend storage with GCS
storage "gcs" {
  bucket    = "${vault_tls_bucket}"
  ha_enabled = "true"
}


# Create local non-TLS listener
listener "tcp" {
  address     = "0.0.0.0:${vault_port}"
  tls_disable = "true"
}

seal "gcpckms" {
  project     = "${kms_project}"
  region      = "${kms_location}"
  key_ring    = "${kms_keyring}"
  crypto_key  = "${kms_crypto_key}"
}

# Enable the UI
ui = true

api_addr = "http://INTERNAL_IP:8200"